import 'dart:async';

void main() async {
  final controller = StreamController<String>();
  controller.sink.add('Hello');
  controller.sink.add('World');
  await for (var value in controller.stream) {
    print(value);
  }
  controller.close();
}