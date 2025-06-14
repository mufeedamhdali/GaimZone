

import '../../Domain/models/app_error.dart';
import '../../Domain/models/auth_state.dart';
import '../../Domain/repositories/user_repository.dart';

class GetAuthStateUseCase {
  final UserRepository _userRepository;

  const GetAuthStateUseCase(this._userRepository);

  Single<Result<AuthenticationState>> call() =>
      _userRepository.authenticationState;
}
