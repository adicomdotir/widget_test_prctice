part of 'custom_bloc.dart';

class CustomEvent {
  final int count;
  CustomEvent({required this.count});
}

class CustomEvent1 extends CustomEvent {
  CustomEvent1(int count) : super(count: count);
}

class CustomEvent2 extends CustomEvent {
  CustomEvent2(int count) : super(count: count);
}

class ResetEvent extends CustomEvent {
  ResetEvent() : super(count: 0);
}
