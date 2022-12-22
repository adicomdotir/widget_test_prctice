import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

final sl = GetIt.instance;

class AppRoutes {
  static String initial = '/';
  static String home = 'home page';
  static String login = 'login page';
  static String register = 'register page';
}

final routeGenerate = {
  AppRoutes.initial: (context) => const HomePage(),
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.register: (context) => const RegisterPage(),
};

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      routes: routeGenerate,
      initialRoute: AppRoutes.initial,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    print(AppBar().preferredSize.height);
    print(MediaQuery.of(context).padding);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: textWithContainer(Colors.red, '1'),
                  ),
                  Flexible(
                    child: textWithContainer(Colors.green, '2'),
                    fit: FlexFit.tight,
                  ),
                  Flexible(
                    child: textWithContainer(Colors.blue, '3'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: textWithContainer(Colors.redAccent, '1'),
                  ),
                  Expanded(
                    child: textWithContainer(Colors.greenAccent, '2'),
                  ),
                  Expanded(
                    child: textWithContainer(Colors.blueAccent, '3'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textWithContainer(Color color, String txt) => Container(
        color: color,
        child: Text(txt),
      );
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Text(AppRoutes.login.toUpperCase()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text(AppRoutes.home.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
