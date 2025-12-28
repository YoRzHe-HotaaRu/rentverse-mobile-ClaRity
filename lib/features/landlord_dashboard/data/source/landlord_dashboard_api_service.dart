import 'package:rentverse/core/network/dio_client.dart';
import '../../domain/entity/dashboard_entity_response.dart';

abstract class LandlordDashboardApiService {
  Future<DashboardResponseEntity> getDashboard();
}

class LandlordDashboardApiServiceImpl implements LandlordDashboardApiService {
  final DioClient _dioClient;

  LandlordDashboardApiServiceImpl(this._dioClient);

  @override
  Future<DashboardResponseEntity> getDashboard() async {
    try {
      final resp = await _dioClient.get('/landlord/dashboard');
      return DashboardResponseEntity.fromJson(
        resp.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
