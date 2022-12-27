import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/provider_sample/provider_10/model/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return ChangeNotifierProvider<Dog>(
      create: (context) => Dog(name: 'name10', breed: 'breed10'),
      child: MaterialApp(
        title: 'Provider 10',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 10'),
      ),
      body: Selector<Dog, String>(
        selector: (context, Dog dog) => dog.name,
        builder: (context, String name, child) {
          debugPrint('Build $runtimeType Selector');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '- name: $name',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const BreedAndAge(),
              ],
            ),
          );
        },
        child: const Text(
          'I like dogs very much.',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Selector<Dog, String>(
      selector: (context, dog) => dog.breed,
      builder: (context, String breed, child) {
        debugPrint('Build $runtimeType Selector');
        return Column(
          children: [
            Text(
              '- breed: $breed',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Age(),
          ],
        );
      },
    );
  }
}

class Age extends StatelessWidget {
  const Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Selector<Dog, int>(
      selector: (context, Dog dog) => dog.age,
      builder: (context, int age, child) {
        debugPrint('Build $runtimeType Selector');
        return Column(
          children: [
            Text(
              '- age: $age',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => context.read<Dog>().grow(),
              child: const Text(
                'Grow',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        );
      },
    );
  }
}