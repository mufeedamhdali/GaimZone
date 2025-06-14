import 'dart:io';

import 'package:cupertino_http/cupertino_http.dart';
import 'package:disposebag/disposebag.dart';
import 'package:flutter/foundation.dart'
    show debugPrint, debugPrintSynchronously, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_hoc081098/http_client_hoc081098.dart';
import 'package:gaimzone/app.dart';
import 'package:gaimzone/Data/local/local_data_source.dart';
import 'package:gaimzone/Data/local/method_channel_crypto_impl.dart';
import 'package:gaimzone/Data/local/shared_pref_util.dart';
import 'package:gaimzone/Data/remote/api_service.dart';
import 'package:gaimzone/Data/remote/auth_interceptor.dart';
import 'package:gaimzone/Data/remote/remote_data_source.dart';
import 'package:gaimzone/Data/user_repository_imp.dart';
import 'package:gaimzone/Domain/repositories/user_repository.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RxStreamBuilder.checkStateStreamEnabled = !kReleaseMode;
  _setupLoggers();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Create http client
  late final Func0<Future<void>> onUnauthorized;
  final simpleHttpClient = createSimpleHttpClient(() => onUnauthorized());

  // construct RemoteDataSource
  final RemoteDataSource remoteDataSource = ApiService(simpleHttpClient);

  // construct LocalDataSource
  final rxPrefs = RxSharedPreferences.getInstance();
  final crypto = MethodChannelCryptoImpl();
  final LocalDataSource localDataSource = SharedPrefUtil(rxPrefs, crypto);
  onUnauthorized = () => localDataSource.removeUserAndToken().first;

  // construct UserRepository
  final UserRepository userRepository = UserRepositoryImpl(
    remoteDataSource,
    localDataSource,
  );

  runApp(
    Provider<UserRepository>.value(
      userRepository,
      child: const MyApp(),
    ),
  );
}

SimpleHttpClient createSimpleHttpClient(
    Func0<Future<void>> onUnauthorized,
    ) {
  final authInterceptor = AuthInterceptor(onUnauthorized: onUnauthorized);

  final loggingInterceptor = SimpleLoggingInterceptor(
    SimpleLogger(
      loggerFunction: print,
      level: kReleaseMode ? SimpleLogLevel.none : SimpleLogLevel.body,
      headersToRedact: {
        ApiService.xAccessToken,
        HttpHeaders.authorizationHeader,
      },
    ),
  );

  final simpleHttpClient = SimpleHttpClient(
    client: Platform.isIOS || Platform.isMacOS
        ? CupertinoClient.defaultSessionConfiguration()
        : http.Client(),
    timeout: const Duration(seconds: 20),
    requestInterceptors: [
      authInterceptor.requestInterceptor,
      // others interceptors above this line
      loggingInterceptor.requestInterceptor,
    ],
    responseInterceptors: [
      loggingInterceptor.responseInterceptor,
      // others interceptors below this line
      authInterceptor.responseInterceptor,
    ],
  );

  return simpleHttpClient;
}

void _setupLoggers() {
  // set loggers to `null` to disable logging.
  DisposeBagConfigs.logger = kReleaseMode ? null : disposeBagDefaultLogger;

  RxSharedPreferencesConfigs.logger =
  kReleaseMode ? null : const RxSharedPreferencesDefaultLogger();

  debugPrint = kReleaseMode
      ? (String? message, {int? wrapWidth}) {}
      : debugPrintSynchronously;
}
