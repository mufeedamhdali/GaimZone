
import 'dart:async';

import 'package:did_change_dependencies/did_change_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_disposebag/flutter_disposebag.dart';
import 'package:gaimzone/utils/snackbar.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../Bloc/Login/login_bloc.dart';
import '../../../State/Login/login_state.dart';
import '../../Widgets/password_textfield.dart';
import '../Home/home_screen.dart';
import '../Register/register_screen.dart';
import '../ResetPassword/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<LoginScreen>
    with
        SingleTickerProviderStateMixin<LoginScreen>,
        DisposeBagMixin,
        DidChangeDependenciesStream {
  late final AnimationController loginButtonController;
  late final Animation<double> buttonSqueezeAnimation;

  final passwordFocusNode = FocusNode();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loginButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: loginButtonController,
        curve: const Interval(
          0.0,
          0.250,
        ),
      ),
    );

    didChangeDependencies$
        .exhaustMap((_) => context.bloc<LoginBloc>().message$)
        .exhaustMap(handleMessage)
        .collect()
        .disposedBy(bag);

    didChangeDependencies$
        .exhaustMap((_) => context.bloc<LoginBloc>().isLoading$)
        .listen((isLoading) {
      if (isLoading) {
        loginButtonController
          ..reset()
          ..forward();
      } else {
        loginButtonController.reverse();
      }
    }).disposedBy(bag);
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(0xBF),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.transparent,
              width: double.infinity,
              height: kToolbarHeight,
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: emailTextField(loginBloc),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: passwordTextField(loginBloc),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginButton(loginBloc),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: needAnAccount(loginBloc),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: forgotPassword(loginBloc),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Stream<void> handleMessage(LoginMessage message) async* {
    switch (message) {
      case LoginSuccessMessage():
        context.showSnackBar('Login successfully');
        await delay(1000);
        yield null;

        context.hideCurrentSnackBar();
        await Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

      case LoginErrorMessage():
        context.showSnackBar(message.message);

      case InvalidInformationMessage():
        context.showSnackBar('Invalid information');
    }
  }

  Widget emailTextField(LoginBloc loginBloc) {
    return StreamBuilder<String?>(
      stream: loginBloc.emailError$,
      builder: (context, snapshot) {
        return TextField(
          controller: emailController,
          autocorrect: true,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(end: 8.0),
              child: Icon(Icons.email),
            ),
            labelText: 'Email',
            errorText: snapshot.data,
          ),
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          style: const TextStyle(fontSize: 16.0),
          onChanged: loginBloc.emailChanged,
          textInputAction: TextInputAction.next,
          autofocus: true,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(passwordFocusNode);
          },
        );
      },
    );
  }

  Widget passwordTextField(LoginBloc loginBloc) {
    return StreamBuilder<String?>(
      stream: loginBloc.passwordError$,
      builder: (context, snapshot) {
        return PasswordTextField(
          errorText: snapshot.data,
          onChanged: loginBloc.passwordChanged,
          labelText: 'Password',
          textInputAction: TextInputAction.done,
          onSubmitted: () {
            FocusScope.of(context).unfocus();
          },
          focusNode: passwordFocusNode,
        );
      },
    );
  }

  Widget loginButton(LoginBloc loginBloc) {
    return AnimatedBuilder(
      animation: buttonSqueezeAnimation,
      builder: (context, child) {
        final value = buttonSqueezeAnimation.value;

        return SizedBox(
          width: value,
          height: 60.0,
          child: Material(
            elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            shadowColor: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(24.0),
            child: value > 75.0
                ? child
                : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
          ),
        );
      },
      child: MaterialButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          loginBloc.submitLogin();
        },
        color: Theme.of(context).colorScheme.surface,
        splashColor: Theme.of(context).colorScheme.secondary,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget needAnAccount(LoginBloc loginBloc) {
    return TextButton(
      onPressed: () async {
        context.hideCurrentSnackBar();
        final email = await Navigator.pushNamed(
          context,
          RegisterScreen.routeName,
        );
        debugPrint('[DEBUG] email = $email');
        if (email != null && email is String) {
          emailController.text = email;
          loginBloc.emailChanged(email);
          FocusScope.of(context).requestFocus(passwordFocusNode);
        }
      },
      child: const Text(
        "Don't have an account? Sign up",
        style: TextStyle(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget forgotPassword(LoginBloc loginBloc) {
    return TextButton(
      onPressed: () async {
        context.hideCurrentSnackBar();
        final email = await Navigator.pushNamed(
          context,
          ResetPasswordScreen.routeName,
        );
        debugPrint('[DEBUG] email = $email');
        if (email != null && email is String) {
          emailController.text = email;
          loginBloc.emailChanged(email);
          FocusScope.of(context).requestFocus(passwordFocusNode);
        }
      },
      child: const Text(
        'Forgot password?',
        style: TextStyle(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
