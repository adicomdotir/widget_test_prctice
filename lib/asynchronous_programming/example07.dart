void main() async {
  await for (var value in getNumbers()) {
    print(value);
  }

  print('-------------------------------------');
  await for (var value in getNumbers(
    end: 10,
    f: evenNumber,
  )) {
    print(value);
  }

  print('-------------------------------------');
  await for (var value in getNumbers(
    end: 10,
    f: oddNumber,
  )) {
    print(value);
  }
}

bool evenNumber(int value) => value % 2 == 0;
bool oddNumber(int value) => value % 2 != 0;

typedef IsIncluded = bool Function(int);

Stream<int> getNumbers({
  int start = 0,
  int end = 4,
  IsIncluded? f,
}) async* {
  for (var i = start; i < end; i++) {
    if (f == null || f(i)) {
      yield i;
    }
  }
}
