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

class User {
  final int id;
  final String name;

  User(this.id, this.name) {
    'Constructor Called'.log();
  }

  @override
  String toString() {
    return 'User (id: $id, name: $name)';
  }
}

void main() {
  'Main Function Running'.log();
  // sl.registerFactory<User>(() {
  //   final id = Random().nextInt(8999) + 1000;
  //   return User(id, 'User$id');
  // });
  sl.registerLazySingleton<User>(() {
    return User(1, 'User1');
  });

  'User logging section'.log();
  for (var i = 0; i < 10; i++) {
    final user = sl<User>();
    user.log();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                Navigator.pushNamed(context, AppRoutes.login);
              },
              child: Text(AppRoutes.login.toUpperCase()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.register);
              },
              child: Text(AppRoutes.register.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const MyCustomForm(),
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

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
// Build Form widget using the _formKey created
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter name',
                labelText: 'Name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter phone number',
                labelText: 'Phone',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Enter date of birth',
                labelText: 'DOB',
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
