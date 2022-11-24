import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

String getFullName(
  String? firstname,
  String? lastname,
) {
  return withAll(
        [firstname, lastname],
        (names) => names.join(' '),
      ) ??
      'Empty';
}

T? withAll<T>(
  List<T?> optionals,
  T Function(List<T>) callback,
) =>
    optionals.any((e) => e == null) ? null : callback(optionals.cast<T>());

void main(List<String> args) {
  'Main Start'.log();
  getFullName('firstname', 'lastname').log();
  getFullName(null, 'lastname').log();
}
