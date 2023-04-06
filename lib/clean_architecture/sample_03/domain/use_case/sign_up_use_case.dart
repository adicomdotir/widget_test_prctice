import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/domain/respsitory/user_repository.dart';

abstract class SignUpUseCase {
  Future<void> execute(User user);
}

class SignUpUseCaseImpl implements SignUpUseCase {
  final UserRepository userRepository;

  SignUpUseCaseImpl({required this.userRepository});

  @override
  Future<void> execute(User user) async {
    await userRepository.signUp(user);
  }
}
