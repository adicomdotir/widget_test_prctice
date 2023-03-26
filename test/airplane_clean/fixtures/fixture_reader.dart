import 'dart:io';

String fixture(String name) =>
    File('test/airplane_clean/fixtures/$name').readAsStringSync();
