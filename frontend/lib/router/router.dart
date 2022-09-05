import 'package:employee_managment/views/auth/login.dart';
import 'package:employee_managment/views/auth/otp_login.dart';
import 'package:employee_managment/views/main/main_screen_admin.dart';
import 'package:employee_managment/views/main/main_screen_user.dart';
import 'package:employee_managment/views/not_found.dart';
import 'package:employee_managment/views/splash.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static final Handler splashHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Splash());

  static final Handler loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Login());

  static final Handler otpLoginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const OTPLogin());

  static Handler mainHandlerAdmin = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return MainScreenAdmin(page: params['name'][0]);
  });

  static Handler mainHandlerUser = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return MainScreenUser(page: params['name'][0]);
  });

  static Handler notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const NotFound();
  });

  static void setupRouter() {
    router.define(
      '/',
      handler: splashHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      '/ems/login',
      handler: loginHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      '/ems/otp',
      handler: otpLoginHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      '/ems/admin/:name',
      handler: mainHandlerAdmin,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      '/ems/user/:name',
      handler: mainHandlerUser,
      transitionType: TransitionType.inFromRight,
    );

    router.notFoundHandler = notFoundHandler;
  }
}
