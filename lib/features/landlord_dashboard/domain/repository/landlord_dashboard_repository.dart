import '../entity/dashboard_entity_response.dart';

abstract class LandlordDashboardRepository {
  Future<DashboardResponseEntity> getDashboard();
}
