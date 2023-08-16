import 'dart:convert';

import 'dart:io';

import 'dart:isolate';

import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MaterialApp(
      home: IsolateHome(),
    ),
  );
}

class IsolateHome extends StatelessWidget {
  const IsolateHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
      ),
      body: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                expensiveCalculateWithIsolate(10000);
              },
              child: const Text('Calculate'),
            )
          ],
        ),
      ),
    );
  }

  void expensiveCalculateWithIsolate(int stop) async {
    ReceivePort port = ReceivePort();
    final isolate = await Isolate.spawn<List<dynamic>>(
      expensiveCalculate,
      [stop, port.sendPort],
    );
    port.listen((message) {
      debugPrint(message.toString());
    });
    isolate.kill();
  }

  void expensiveCalculate(List<dynamic> object) {
    SendPort sendPort = object[1];
    int stop = object[0];
    int sum = 0;
    for (var index = 0; index < stop; index++) {
      sum += index;
      if (index == stop - 1) {}
    }
    sendPort.send(sum.toString());
  }
}
