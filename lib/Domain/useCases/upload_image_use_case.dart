import 'dart:io';

import '../../Domain/models/app_error.dart';
import '../../Domain/repositories/user_repository.dart';


class UploadImageUseCase {
  final UserRepository _userRepository;

  const UploadImageUseCase(this._userRepository);

  UnitResultSingle call(File image) => _userRepository.uploadImage(image);
}
