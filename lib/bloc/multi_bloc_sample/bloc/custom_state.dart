part of 'custom_bloc.dart';

class CustomState {
  final CountStatus countStatus1;
  final CountStatus countStatus2;
  final MessageStatus messageStatus;

  CustomState({
    required this.countStatus1,
    required this.countStatus2,
    required this.messageStatus,
  });

  CustomState copyWith({
    CountStatus? newCountStatus1,
    CountStatus? newCountStatus2,
    MessageStatus? messageStatus,
  }) {
    return CustomState(
      countStatus1: newCountStatus1 ?? countStatus1,
      countStatus2: newCountStatus2 ?? countStatus2,
      messageStatus: messageStatus ?? this.messageStatus,
    );
  }
}
