part of 'custom_bloc.dart';

class CustomState {
  final CountStatus countStatus1;
  final CountStatus countStatus2;

  CustomState({
    required this.countStatus1,
    required this.countStatus2,
  });

  CustomState copyWith({
    CountStatus? newCountStatus1,
    CountStatus? newCountStatus2,
  }) {
    return CustomState(
      countStatus1: newCountStatus1 ?? countStatus1,
      countStatus2: newCountStatus2 ?? countStatus2,
    );
  }
}
