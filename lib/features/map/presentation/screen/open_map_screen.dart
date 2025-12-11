import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentverse/common/colors/custom_color.dart';
import 'package:rentverse/core/services/service_locator.dart';
import 'package:rentverse/features/map/presentation/cubit/reverse_geocode_cubit.dart';
import 'package:rentverse/features/map/presentation/cubit/reverse_geocode_state.dart';

class OpenMapScreen extends StatefulWidget {
  const OpenMapScreen({
    super.key,
    this.initialLat = -6.200000,
    this.initialLon = 106.816666,
  });

  final double initialLat;
  final double initialLon;

  @override
  State<OpenMapScreen> createState() => _OpenMapScreenState();
}

class _OpenMapScreenState extends State<OpenMapScreen> {
  late LatLng _center;
  late final MapController _mapController;
  // small debounce to avoid spamming reverse geocode while user pans
  Timer? _debounce;
  late final ReverseGeocodeCubit _reverseCubit;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.initialLat, widget.initialLon);
    _mapController = MapController();
    _reverseCubit = ReverseGeocodeCubit(sl())
      ..fetch(_center.latitude, _center.longitude);
    // initial fetch done above; we'll trigger further fetches from onPositionChanged
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _reverseCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reverseCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('OpenStreetMap Preview')),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _center,
                      initialZoom: 14,
                      // also update center quickly for smoother marker
                      onPositionChanged: (pos, hasGesture) {
                        final newCenter = pos.center;
                        setState(() => _center = newCenter);
                        // When user is panning (hasGesture == true) debounce the fetch
                        _debounce?.cancel();
                        if (hasGesture) {
                          _debounce = Timer(
                            const Duration(milliseconds: 600),
                            () {
                              _reverseCubit.fetch(
                                _center.latitude,
                                _center.longitude,
                              );
                            },
                          );
                        } else {
                          // immediate fetch when movement ends
                          _reverseCubit.fetch(
                            _center.latitude,
                            _center.longitude,
                          );
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                        userAgentPackageName: 'com.example.rentverse',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _center,
                            width: 44,
                            height: 44,
                            child: const Icon(
                              Icons.location_pin,
                              size: 44,
                              color: appSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // center crosshair overlay so user knows exact selected point
                  IgnorePointer(
                    child: Center(
                      child: Icon(
                        Icons.add_location_alt,
                        size: 36,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: BlocBuilder<ReverseGeocodeCubit, ReverseGeocodeState>(
                builder: (context, state) {
                  if (state.status == ReverseGeocodeStatus.loading) {
                    return const Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 10),
                        Text('Memuat alamat...'),
                      ],
                    );
                  }
                  if (state.status == ReverseGeocodeStatus.failure) {
                    return Text(
                      state.error ?? 'Gagal memuat alamat',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  final location = state.location;
                  if (location == null) {
                    return const Text('Sentuh peta untuk mendapatkan alamat');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.displayName,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lat: ${location.lat.toStringAsFixed(5)}, Lon: ${location.lon.toStringAsFixed(5)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop({
                              'lat': location.lat,
                              'lon': location.lon,
                              'displayName': location.displayName,
                              'city': location.city,
                              'country': location.country,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1CD8D2),
                          ),
                          child: const Text('Select this location'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
