import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/common/bloc/auth/auth_state.dart';
import 'package:rentverse/core/services/service_locator.dart';
import 'package:rentverse/features/auth/domain/usecase/is_logged_in_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AppInitialState());

  Future<void> checkAuthStatus() async {
    final bool isLoggedIn = await sl<IsLoggedInUsecase>().call(param: Void);
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
