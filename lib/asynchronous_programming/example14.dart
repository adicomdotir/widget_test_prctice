import 'dart:async';
import 'dart:core';

void main() async {
  final result = getNames().asyncExpand((event) => times3(event));
  await for (var item in result) {
    print(item);
  }
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Jill';
}

Stream<String> times3(String value) =>
    Stream.fromIterable(Iterable.generate(3, (_) => value));
