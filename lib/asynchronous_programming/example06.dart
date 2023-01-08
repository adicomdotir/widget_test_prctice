void main() async {
  final sum = await getAllAges().reduce((previous, element) => previous + element);
  print(sum);
}

Stream<int> getAllAges() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
  yield 100;
}
