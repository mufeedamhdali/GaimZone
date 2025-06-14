

import '../../Domain/models/app_error.dart';
import '../../Domain/repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository _userRepository;

  const LogoutUseCase(this._userRepository);

  UnitResultSingle call() => _userRepository.logout();
}
