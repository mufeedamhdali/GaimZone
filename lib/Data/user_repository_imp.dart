import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_client_hoc081098/http_client_hoc081098.dart';
import 'package:gaimzone/Data/exception/local_data_source_exception.dart';
import 'package:gaimzone/Data/exception/remote_data_source_exception.dart';
import 'package:gaimzone/Data/local/entities/user_and_token_entity.dart';
import 'package:gaimzone/Data/local/entities/user_entity.dart';
import 'package:gaimzone/Data/local/local_data_source.dart';
import 'package:gaimzone/Data/remote/remote_data_source.dart';
import 'package:gaimzone/Data/remote/response/user_response.dart';
import 'package:gaimzone/Domain/models/app_error.dart';
import 'package:gaimzone/Domain/models/auth_state.dart';
import 'package:gaimzone/Domain/models/user.dart';
import 'package:gaimzone/Domain/models/user_and_token.dart';
import 'package:gaimzone/Domain/repositories/user_repository.dart';
import 'package:gaimzone/utils/streams.dart';

part 'mappers.dart';

typedef _UserResponseAndToken = ({UserResponse user, String token});

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  @override
  final Stream<Result<AuthenticationState>> authenticationState$;

  @override
  Single<Result<AuthenticationState>> get authenticationState =>
      _localDataSource.userAndToken
          .map(_Mappers.userAndTokenEntityToDomainAuthState)
          .toEitherSingle(_Mappers.errorToAppError);

  UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  ) : authenticationState$ = _localDataSource.userAndToken$
            .map(_Mappers.userAndTokenEntityToDomainAuthState)
            .toEitherStream(_Mappers.errorToAppError)
            .publishValue()
          ..listen((state) => debugPrint('[USER_REPOSITORY] state=$state'))
          ..connect() {
    _init().ignore();
  }

  @override
  UnitResultSingle login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource
        .loginUser(email, password)
        .toEitherSingle(_Mappers.errorToAppError)
        .flatMapEitherSingle((result) {
          final token = result.token!;

          return _remoteDataSource
              .getUserProfile(email, token)
              .map<_UserResponseAndToken>((user) => (user: user, token: token))
              .toEitherSingle(_Mappers.errorToAppError);
        })
        .flatMapEitherSingle(
          (tuple) => _localDataSource
              .saveUserAndToken(
                _Mappers.userResponseToUserAndTokenEntity(
                  tuple.user,
                  tuple.token,
                ),
              )
              .toEitherSingle(_Mappers.errorToAppError),
        )
        .asUnit();
  }

  @override
  UnitResultSingle registerUser({
    required String name,
    required String email,
    required String password,
  }) =>
      _remoteDataSource
          .registerUser(name, email, password)
          .toEitherSingle(_Mappers.errorToAppError)
          .asUnit();

  @override
  UnitResultSingle logout() => _localDataSource
      .removeUserAndToken()
      .toEitherSingle(_Mappers.errorToAppError)
      .asUnit();

  @override
  UnitResultSingle uploadImage(File image) {
    return _userAndToken
        .flatMapEitherSingle((userAndToken) {
          if (userAndToken == null) {
            return Single.value(
              AppError(
                message: 'Require login!',
                error: 'Email or token is null',
                stackTrace: StackTrace.current,
              ).left<_UserResponseAndToken>(),
            );
          }

          return _remoteDataSource
              .uploadImage(
                image,
                userAndToken.user.email,
                userAndToken.token,
              )
              .map<_UserResponseAndToken>(
                  (user) => (user: user, token: userAndToken.token))
              .toEitherSingle(_Mappers.errorToAppError);
        })
        .flatMapEitherSingle(
          (tuple) => _localDataSource
              .saveUserAndToken(
                _Mappers.userResponseToUserAndTokenEntity(
                  tuple.user,
                  tuple.token,
                ),
              )
              .toEitherSingle(_Mappers.errorToAppError),
        )
        .asUnit();
  }

  @override
  UnitResultSingle changePassword({
    required String password,
    required String newPassword,
  }) {
    return _userAndToken.flatMapEitherSingle((userAndToken) {
      if (userAndToken == null) {
        return Single.value(
          AppError(
            message: 'Require login!',
            error: 'Email or token is null',
            stackTrace: StackTrace.current,
          ).left(),
        );
      }

      return _remoteDataSource
          .changePassword(
            userAndToken.user.email,
            password,
            newPassword,
            userAndToken.token,
          )
          .toEitherSingle(_Mappers.errorToAppError)
          .asUnit();
    });
  }

  @override
  UnitResultSingle resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) =>
      _remoteDataSource
          .resetPassword(
            email,
            token: token,
            newPassword: newPassword,
          )
          .toEitherSingle(_Mappers.errorToAppError)
          .asUnit();

  @override
  UnitResultSingle sendResetPasswordEmail(String email) => _remoteDataSource
      .resetPassword(email)
      .toEitherSingle(_Mappers.errorToAppError)
      .asUnit();

  ///
  /// Helpers functions
  ///

  /// TODO: Replace with interceptor
  Single<Result<UserAndTokenEntity?>> get _userAndToken =>
      _localDataSource.userAndToken.toEitherSingle(_Mappers.errorToAppError);

  ///
  /// Check auth when starting app
  ///
  Future<void> _init() async {
    const tag = '[USER_REPOSITORY] { init }';

    try {
      final userAndToken = await _localDataSource.userAndToken.first;
      debugPrint('$tag userAndToken local=$userAndToken');

      if (userAndToken == null) {
        return;
      }

      final userProfile = await _remoteDataSource
          .getUserProfile(
            userAndToken.user.email,
            userAndToken.token,
          )
          .first;

      debugPrint('$tag userProfile server=$userProfile');
      await _localDataSource
          .saveUserAndToken(
            _Mappers.userResponseToUserAndTokenEntity(
              userProfile,
              userAndToken.token,
            ),
          )
          .first;
    } on RemoteDataSourceException catch (e) {
      debugPrint('$tag remote error=$e');
    } on LocalDataSourceException catch (e) {
      debugPrint('$tag local error=$e');
      await _localDataSource.removeUserAndToken().first;
    }
  }
}
