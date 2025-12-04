// lib/core/usecase/usecase.dart

class NoParams {}

abstract class UseCase<T, Param> {
  Future<T> call({Param? param});
}
