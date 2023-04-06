import 'dart:math';

import 'package:flutter/material.dart';

void main(List<String> args) {
  var foo = const ['a']; // if you want add value to this list throw exception!
  print(foo);
  foo = [];
  print(foo);

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: NewWidget(),
      ),
    ),
  );
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  String message = '0';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 90,
              minWidth: 45,
              maxHeight: 90,
            ),
            child: Container(
              color: Colors.blueAccent,
              child: Text(message),
            ),
          ),
          SizedBox(
            height: 64.0,
          ),
          ElevatedButton(
            onPressed: () {
              final newNum = Random().nextInt(90) + 10;
              message += ' $newNum';
              setState(() {});
            },
            child: const Text('Add Random Number'),
          ),
        ],
      ),
    );
  }
}
