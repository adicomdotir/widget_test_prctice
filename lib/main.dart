void main() {
  final counter = Counter();
  try {
    // counter.decrement();
    // print(counter.toString());
    counter.increment();
    print(counter.toString());
    counter.increment();
    print(counter.toString());
    counter.increment();
    // top method throw exception so below code not invoked
    print(counter.toString());
  } on CustomException catch (e) {
    print(e);
    print(e.runtimeType);
  }
}

class Counter {
  int _count = 0;

  void increment() {
    _count++;
    if (_count > 2) {
      throw CustomException(_count, 'counter is bigger than 2.');
    }
  }

  void decrement() {
    _count--;
    if (_count < 0) {
      throw ('counter is smaller than 0.');
    }
  }

  @override
  String toString() {
    return 'Counter[count: $_count]';
  }
}

class CustomException implements Exception {
  int count;
  String message;

  CustomException(
    this.count,
    this.message,
  );

  @override
  String toString() {
    return '$count $message';
  }
}
