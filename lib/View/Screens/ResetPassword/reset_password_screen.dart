import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_disposebag/flutter_disposebag.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:gaimzone/View/Screens/ResetPassword/send_email/send_email_screen.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../Bloc/ResetPassword/InputToken/input_token_and_reset_password_bloc.dart';
import '../../../Bloc/ResetPassword/SendEmail/send_email_bloc.dart';
import '../../../Domain/useCases/reset_password_use_case.dart';
import '../../../Domain/useCases/send_reset_password_email_use_case.dart';
import 'input_token/input_token_and_reset_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset_password_screen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin<ResetPasswordScreen>, DisposeBagMixin {
  final requestEmailS = StreamController<void>(sync: true);
  late final StateStream<bool> requestEmail$;

  late final AnimationController animationController;
  late final Animation<Offset> animationPosition;
  late final Animation<double> animationScale;
  late final Animation<double> animationOpacity;
  late final Animation<double> animationTurns;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationPosition = Tween(
      begin: const Offset(2.0, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );
    animationScale = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationTurns = Tween<double>(
      begin: 0.5,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    /// Stream of bool values.
    /// Emits true if current page is request email page.
    /// Otherwise, it is reset password page.
    requestEmail$ = requestEmailS.stream
        .scan<bool>((acc, e, _) => !acc, true)
        .doOnData((requestEmailPage) => requestEmailPage
            ? animationController.reverse()
            : animationController.forward())
        .publishState(true)
      ..connect().disposedBy(bag);
    requestEmailS.disposedBy(bag);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onToggle() => requestEmailS.add(null);

  @override
  Widget build(BuildContext context) {
    final sendEmailPage = BlocProvider<SendEmailBloc>(
      initBloc: (context) => SendEmailBloc(
        SendResetPasswordEmailUseCase(context.get()),
      ),
      child: SendEmailScreen(toggle: onToggle),
    );

    final resetPasswordPage = BlocProvider<InputTokenAndResetPasswordBloc>(
      initBloc: (context) => InputTokenAndResetPasswordBloc(
        ResetPasswordUseCase(context.get()),
      ),
      child: InputTokenAndResetPasswordScreen(toggle: onToggle),
    );

    return Scaffold(
      appBar: AppBar(
        title: RxStreamBuilder<bool>(
          stream: requestEmail$,
          builder: (context, requestEmailPage) {
            return Text(requestEmailPage ? 'Request email' : 'Reset password');
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: sendEmailPage),
          Positioned.fill(
            child: RotationTransition(
              turns: animationTurns,
              child: SlideTransition(
                position: animationPosition,
                child: ScaleTransition(
                  scale: animationScale,
                  child: FadeTransition(
                    opacity: animationOpacity,
                    child: resetPasswordPage,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
