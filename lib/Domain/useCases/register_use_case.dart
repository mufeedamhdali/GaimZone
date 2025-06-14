

import '../../Domain/models/app_error.dart';
import '../../Domain/repositories/user_repository.dart';

class RegisterUseCase {
  final UserRepository _userRepository;

  const RegisterUseCase(this._userRepository);

  UnitResultSingle call({
    required String name,
    required String email,
    required String password,
  }) =>
      _userRepository.registerUser(
        name: name,
        email: email,
        password: password,
      );
}
