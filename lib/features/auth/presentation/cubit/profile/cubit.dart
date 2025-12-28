import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/core/resources/data_state.dart';
import 'package:rentverse/features/auth/domain/usecase/get_user_usecase.dart';

import 'package:dio/dio.dart';
import 'package:rentverse/core/utils/error_utils.dart';

import 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUseCase _getUserUseCase;

  ProfileCubit(this._getUserUseCase) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final result = await _getUserUseCase();

      if (result is DataSuccess && result.data != null) {
        emit(state.copyWith(status: ProfileStatus.success, user: result.data));
      } else if (result is DataFailed) {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: result.errorMessage ?? 'Unknown error',
            statusCode: result.error?.response?.statusCode,
          ),
        );
      }
    } catch (e) {
      final msg = e is DioException ? resolveApiErrorMessage(e) : e.toString();
      final statusCode = e is DioException ? e.response?.statusCode : null;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: msg,
          statusCode: statusCode,
        ),
      );
    }
  }
}
