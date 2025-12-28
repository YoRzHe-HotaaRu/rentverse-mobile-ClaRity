import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/auth/domain/usecase/get_local_user_usecase.dart';
import 'package:rentverse/features/landlord_dashboard/domain/usecase/get_landlord_dashboard_usecase.dart';
import 'landlord_dashboard_state.dart';

class LandlordDashboardCubit extends Cubit<LandlordDashboardState> {
  final GetLocalUserUseCase _getLocalUser;
  final GetLandlordDashboardUseCase _getDashboard;

  LandlordDashboardCubit(this._getLocalUser, this._getDashboard)
    : super(const LandlordDashboardState());

  Future<void> load() async {
    emit(
      state.copyWith(
        status: LandlordDashboardStatus.loading,
        errorMessage: null,
      ),
    );
    try {
      final user = await _getLocalUser();
      final dashboard = await _getDashboard();
      emit(
        state.copyWith(
          status: LandlordDashboardStatus.success,
          user: user,
          dashboard: dashboard,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LandlordDashboardStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> refresh() => load();
}
