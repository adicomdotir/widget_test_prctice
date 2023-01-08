void main() async {
  await for(var name in allNames()) {
    print(name);
  }
}

Stream<String> maleNames() async* {
  yield 'John';
  yield 'Peter';
  yield 'Paul';
}

Stream<String> femaleNames() async* {
  yield 'Jane';
  yield 'Mary';
  yield 'Sue';
}

Stream<String> allNames() async* {
  yield* maleNames();
  yield* femaleNames();
}