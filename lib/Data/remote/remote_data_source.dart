import 'dart:io';

import 'package:gaimzone/Data/remote/response/token_response.dart';
import 'package:gaimzone/Data/remote/response/user_response.dart';
import 'package:gaimzone/Domain/models/app_error.dart';

abstract class RemoteDataSource {
  Single<TokenResponse> loginUser(String email, String password);

  Single<TokenResponse> registerUser(
    String name,
    String email,
    String password,
  );

  Single<TokenResponse> changePassword(
    String email,
    String password,
    String newPassword,
    String token,
  );

  Single<TokenResponse> resetPassword(
    String email, {
    String? token,
    String? newPassword,
  });

  Single<UserResponse> getUserProfile(String email, String token);

  Single<UserResponse> uploadImage(
    File file,
    String email,
    String token,
  );
}
