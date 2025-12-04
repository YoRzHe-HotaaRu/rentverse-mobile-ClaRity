import 'package:rentverse/features/auth/domain/entity/login_request_entity.dart';
import 'package:rentverse/features/auth/domain/entity/user_entity.dart';
import 'package:rentverse/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LoginUseCase
    implements UseCase<DataState<UserEntity>, LoginRequestEntity> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call({LoginRequestEntity? param}) {
    if (param == null) {
      throw const FormatException("Login Params tidak boleh null");
    }
    return _authRepository.login(param);
  }
}
