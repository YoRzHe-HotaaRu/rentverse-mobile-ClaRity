import '../../../../core/usecase/usecase.dart';
import '../entity/dashboard_entity_response.dart';
import '../repository/landlord_dashboard_repository.dart';

class GetLandlordDashboardUseCase
    implements UseCase<DashboardResponseEntity, NoParams> {
  final LandlordDashboardRepository _repository;

  GetLandlordDashboardUseCase(this._repository);

  @override
  Future<DashboardResponseEntity> call({NoParams? param}) {
    return _repository.getDashboard();
  }
}
