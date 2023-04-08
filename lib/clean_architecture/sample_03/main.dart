import 'package:flutter/material.dart';

import 'data/data_source/firebase_user_data_source.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/use_case/login_use_case.dart';
import 'domain/use_case/sign_up_use_case.dart';
import 'presentation/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseUserDataSource = FirebaseUserDataSource();
  final userRepository = UserRepositoryImpl(
    firebaseUserDataSource: firebaseUserDataSource,
  );
  final signUpUseCase = SignUpUseCaseImpl(userRepository: userRepository);
  final loginUseCase = LoginUseCaseImpl(userRepository: userRepository);

  runApp(
    MyApp(
      signUpUseCase: signUpUseCase,
      loginUseCase: loginUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  const MyApp({
    required this.signUpUseCase,
    required this.loginUseCase,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      home: SignUpScreen(signUpUseCase: signUpUseCase),
    );
  }
}
