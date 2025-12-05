// lib/common/screen/navigation_container.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rentverse/common/colors/custom_color.dart';

import '../bloc/navigation/navigation_cubit.dart';

class NavigationContainer extends StatelessWidget {
  final List<Widget>? pages;
  final List<BottomNavigationBarItem>? items;

  const NavigationContainer({super.key, this.pages, this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        body: _buildBody(pages),
        bottomNavigationBar: _buildBottomNavigationBar(context, items),
      ),
    );
  }
}

Widget _buildBody(List<Widget>? pages) {
  return BlocBuilder<NavigationCubit, int>(
    builder: (context, index) {
      final resolvedPages = pages ?? _defaultPages();
      return IndexedStack(index: index, children: resolvedPages);
    },
  );
}

List<Widget> _defaultPages() => const [
  _TextPlaceholder('Home'),
  _TextPlaceholder('Search'),
  _TextPlaceholder('Profile'),
];

class _TextPlaceholder extends StatelessWidget {
  final String title;
  const _TextPlaceholder(this.title);
  @override
  Widget build(BuildContext context) => Center(child: Text(title));
}

Widget _buildBottomNavigationBar(
  BuildContext context,
  List<BottomNavigationBarItem>? items,
) {
  return BlocBuilder<NavigationCubit, int>(
    builder: (context, index) {
      final barItems =
          items ??
          const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ];
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 8,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (i) => context.read<NavigationCubit>().updateIndex(i),
          selectedItemColor: appPrimaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: barItems,
        ),
      );
    },
  );
}

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const GradientIcon({super.key, required this.icon, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return customLinearGradient.createShader(
          Rect.fromLTWH(0, 0, size, size),
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon, color: Colors.white, size: size),
      ),
    );
  }
}
