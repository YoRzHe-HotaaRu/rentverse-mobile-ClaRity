import 'package:meta/meta.dart';
import 'package:rentverse/features/landlord_dashboard/domain/entity/dashboard_entity_response.dart';
import 'package:rentverse/features/auth/domain/entity/user_entity.dart';

enum LandlordDashboardStatus { initial, loading, success, failure }

@immutable
class LandlordDashboardState {
  final LandlordDashboardStatus status;
  final DashboardResponseEntity? dashboard;
  final UserEntity? user;
  final String? errorMessage;

  const LandlordDashboardState({
    this.status = LandlordDashboardStatus.initial,
    this.dashboard,
    this.user,
    this.errorMessage,
  });

  LandlordDashboardState copyWith({
    LandlordDashboardStatus? status,
    DashboardResponseEntity? dashboard,
    UserEntity? user,
    String? errorMessage,
  }) {
    return LandlordDashboardState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
