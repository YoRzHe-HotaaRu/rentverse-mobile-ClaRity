import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/auth/domain/usecase/get_local_user_usecase.dart';

import 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetLocalUserUseCase _getLocalUserUseCase;

  ProfileCubit(this._getLocalUserUseCase) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _getLocalUserUseCase();
      if (user != null) {
        emit(state.copyWith(status: ProfileStatus.success, user: user));
      } else {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'User not found',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
