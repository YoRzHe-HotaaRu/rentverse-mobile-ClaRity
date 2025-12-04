import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/auth/domain/repository/auth_repository.dart';

class IsLoggedInUsecase implements UseCase<bool, dynamic> {
  final AuthRepository _authRepository;
  IsLoggedInUsecase(this._authRepository);
  @override
  Future<bool> call({param}) {
    return _authRepository.isLoggedIn();
  }
}
