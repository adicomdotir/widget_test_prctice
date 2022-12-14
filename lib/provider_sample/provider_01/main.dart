import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

TextStyle textStyle = const TextStyle(fontSize: 24.0);
SizedBox sizedBox = const SizedBox(height: 20.0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CounterApp'),
        ),
        body: const MyHomePage(),
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
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue[100],
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'MyHomePage',
              style: textStyle,
            ),
          ),
          sizedBox,
          CounterA(
            counter: counter,
            increment: increment,
          ),
          sizedBox,
          Middle(counter: counter),
        ],
      ),
    );
  }
}

class CounterA extends StatelessWidget {
  final int counter;
  final void Function() increment;

  const CounterA({
    Key? key,
    required this.counter,
    required this.increment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Container(
      color: Colors.red[100],
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            '$counter',
            style: textStyle,
          ),
          ElevatedButton(
            onPressed: increment,
            child: const Text(
              'Increment',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Middle extends StatelessWidget {
  final int counter;

  const Middle({
    Key? key,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CounterB(counter: counter),
          const SizedBox(
            width: 20.0,
          ),
          const Sibling(),
        ],
      ),
    );
  }
}

class CounterB extends StatelessWidget {
  final int counter;

  const CounterB({
    Key? key,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(20.0),
      child: Text(
        '$counter',
        style: textStyle,
      ),
    );
  }
}

class Sibling extends StatelessWidget {
  const Sibling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Container(
      color: Colors.orange[100],
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Sibling',
        style: textStyle,
      ),
    );
  }
}
