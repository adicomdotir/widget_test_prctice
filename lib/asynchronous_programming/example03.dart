void main() async {
  final length = await getFullName().then((value) => calculateLength(value));
  print(length);
}

Future<String> getFullName() =>
    Future.delayed(const Duration(seconds: 1), () => 'John Doe');

Future<int> calculateLength(String value) =>
    Future.delayed(const Duration(seconds: 1), () => value.length);
