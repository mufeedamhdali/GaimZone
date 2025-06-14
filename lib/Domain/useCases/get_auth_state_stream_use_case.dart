

import '../../Domain/models/app_error.dart';
import '../../Domain/models/auth_state.dart';
import '../../Domain/repositories/user_repository.dart';

class GetAuthStateStreamUseCase {
  final UserRepository _userRepository;

  const GetAuthStateStreamUseCase(this._userRepository);

  Stream<Result<AuthenticationState>> call() =>
      _userRepository.authenticationState$;
}
