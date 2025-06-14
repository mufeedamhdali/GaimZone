import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_disposebag/flutter_disposebag.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gaimzone/Domain/models/app_error.dart';
import 'package:gaimzone/Domain/models/auth_state.dart';
import 'package:gaimzone/Domain/repositories/user_repository.dart';
import 'package:gaimzone/Domain/useCases/get_auth_state_stream_use_case.dart';
import 'package:gaimzone/Domain/useCases/get_auth_state_use_case.dart';
import 'package:gaimzone/Domain/useCases/login_use_case.dart';
import 'package:gaimzone/Domain/useCases/logout_use_case.dart';
import 'package:gaimzone/Domain/useCases/register_use_case.dart';
import 'package:gaimzone/Domain/useCases/upload_image_use_case.dart';
import 'package:gaimzone/View/screens/login/login.dart';
import 'package:gaimzone/View/screens/register/register.dart';
import 'package:gaimzone/utils/streams.dart';

import 'package:gaimzone/utils/theme.dart';

import 'View/Screens/Auction/auction.dart';
import 'View/Screens/Home/home.dart';
import 'View/Screens/ResetPassword/reset_password_screen.dart';
import 'View/Screens/Splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      // Navigator.defaultRouteName: (context) {
      //   return Provider<GetAuthStateUseCase>.factory(
      //     (context) => GetAuthStateUseCase(context.get()),
      //     child: const Home(),
      //   );
      // },
      Navigator.defaultRouteName: (context) {
        return  const SplashScreen();
      },
      RegisterScreen.routeName: (context) {
        return BlocProvider<RegisterBloc>(
          initBloc: (context) => RegisterBloc(
            RegisterUseCase(context.get()),
          ),
          child: const RegisterScreen(),
        );
      },
      HomeScreen.routeName: (context) {
        return BlocProvider<HomeBloc>(
          initBloc: (context) {
            final userRepository = context.get<UserRepository>();
            return HomeBloc(
              LogoutUseCase(userRepository),
              GetAuthStateStreamUseCase(userRepository),
              UploadImageUseCase(userRepository),
            );
          },
          child: const HomeScreen(),
        );
      },
      AuctionScreen.routeName: (context) {
        return BlocProvider<AuctionBloc>(
          initBloc: (context) {
            final userRepository = context.get<UserRepository>();
            return AuctionBloc(
              LogoutUseCase(userRepository),
              GetAuthStateStreamUseCase(userRepository),
              UploadImageUseCase(userRepository),
            );
          },
          child: const AuctionScreen(),
        );
      },
      LoginScreen.routeName: (context) {
        return BlocProvider<LoginBloc>(
          initBloc: (context) => LoginBloc(
            LoginUseCase(context.get()),
          ),
          child: const LoginScreen(),
        );
      },
      ResetPasswordScreen.routeName: (context) {
        return const ResetPasswordScreen();
      },
      SplashScreen.routeName: (context) {
        return const SplashScreen();
      },
    };

    return Provider<Map<String, WidgetBuilder>>.value(
      routes,
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        title: 'Gaim Zone',
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with DisposeBagMixin {
  late final StateStream<Result<AuthenticationState>?> authState$;

  @override
  void initState() {
    super.initState();

    final getAuthState = Provider.of<GetAuthStateUseCase>(context);
    authState$ = getAuthState().castAsNullable().publishState(null)
      ..connect().disposedBy(bag);
  }

  @override
  Widget build(BuildContext context) {
    final routes = Provider.of<Map<String, WidgetBuilder>>(context);

    return RxStreamBuilder<Result<AuthenticationState>?>(
      stream: authState$,
      builder: (context, result) {
        if (result == null) {
          debugPrint('[HOME] home [1] >> [waiting...]');

          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).cardColor,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        }

        return result.fold(
          ifLeft: (appError) {
            debugPrint(
                '[HOME] home [2] >> [error -> NotAuthenticated] error=$appError');
            return routes[LoginScreen.routeName]!(context);
          },
          ifRight: (authState) {
            if (authState is UnauthenticatedState) {
              debugPrint('[HOME] home [3] >> [Unauthenticated]');
              return routes[LoginScreen.routeName]!(context);
            }

            if (authState is AuthenticatedState) {
              debugPrint('[HOME] home [4] >> [Authenticated]');
              return routes[HomeScreen.routeName]!(context);
            }

            throw StateError('Unknown auth state: $authState');
          },
        );
      },
    );
  }
}
