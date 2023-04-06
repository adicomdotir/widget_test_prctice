import 'package:widget_test_practice/clean_architecture/sample_03/domain/respsitory/user_repository.dart';

abstract class LoginUseCase {
  Future<void> execute(String email, String password);
}

class LoginUseCaseImpl implements LoginUseCase {
  final UserRepository userRepository;

  LoginUseCaseImpl({required this.userRepository});

  @override
  Future<void> execute(String email, String password) async {
    await userRepository.login(email, password);
  }
}
