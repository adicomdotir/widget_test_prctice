import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main(List<String> args) {
  testIt();
}

void testIt() {
  Cat cat = Cat()..run();
  (cat is CanWalk).log();
}

mixin CanWalk {
  int get speed;

  void run() {
    'CanWalk speed = $speed'.log();
  }
}

class Cat with CanWalk {
  @override
  int speed = 10;
}
