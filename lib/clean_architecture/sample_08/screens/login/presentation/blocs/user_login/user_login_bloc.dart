import 'package:bloc/bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_08/screens/login/presentation/blocs/user_login/bloc.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc() : super(LoadingState()) {
    on<UserLoginEvent>((event, emit) {});
  }
}
