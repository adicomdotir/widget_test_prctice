import 'dart:async';
import 'dart:core';

void main() async {
  await broadcastStreamExample();
}

Future<void> broadcastStreamExample() async {
  late final StreamController<String> controller;
  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print('sub1: $name');
  });

  final sub2 = controller.stream.listen((name) {
    print('sub2: $name');
  });

  controller.sink.add('John');
  controller.sink.add('Jane');

  controller.close();

  controller.onCancel = () {
    print('onCancel');
    sub1.cancel();
    sub2.cancel();
  };
}