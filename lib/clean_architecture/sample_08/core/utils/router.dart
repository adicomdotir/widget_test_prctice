import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_08/screens/login/presentation/page/login.dart';
import 'constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // case HOME_ROUTE:
      //   return MaterialPageRoute(builder: (_) => HomePage());
      // case CHANGE_PASSWORD_ROUTE:
      //   return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
