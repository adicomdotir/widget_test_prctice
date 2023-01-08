import 'dart:async';
import 'dart:core';

void main() async {
  final allNames =  await getNames().toList();
  print(allNames);
}

Stream<String> getNames() async* {
  await Future.delayed(Duration(seconds: 5));
  yield 'John';
  yield 'Jane';
  yield 'Jack';
}