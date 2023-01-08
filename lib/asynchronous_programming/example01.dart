void main() async {
  print(await getUserName());
  print(await getAddress());
  print(await getPhoneNumber());
  print(await getCity());
  print(await getCountry());
  print(await getZipCode());
}

Future<String> getUserName() async => 'John Doe';

Future<String> getAddress() => Future.value('123 Main Street');

Future<String> getPhoneNumber() => Future.delayed(const Duration(seconds: 1), () => '555-555-5555');

Future<String> getCity() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Ardabil';
}

Future<String> getCountry() async => 'Turkey';

Future<String> getZipCode() {
  return Future.delayed(const Duration(seconds: 1), () => '12345');
}
