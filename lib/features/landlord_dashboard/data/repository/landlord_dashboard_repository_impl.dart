import '../../domain/entity/dashboard_entity_response.dart';
import '../../domain/repository/landlord_dashboard_repository.dart';
import '../source/landlord_dashboard_api_service.dart';

class LandlordDashboardRepositoryImpl implements LandlordDashboardRepository {
  final LandlordDashboardApiService _api;

  LandlordDashboardRepositoryImpl(this._api);

  @override
  Future<DashboardResponseEntity> getDashboard() {
    return _api.getDashboard();
  }
}
