

import '../../Domain/models/app_error.dart';
import '../../Domain/repositories/user_repository.dart';

class ChangePasswordUseCase {
  final UserRepository _userRepository;

  const ChangePasswordUseCase(this._userRepository);

  UnitResultSingle call({
    required String password,
    required String newPassword,
  }) =>
      _userRepository.changePassword(
        password: password,
        newPassword: newPassword,
      );
}
