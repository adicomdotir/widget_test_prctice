import 'dart:io';

String fixture(String name) => File('test/clean_architecture/sample_01/fixtures/$name').readAsStringSync();
