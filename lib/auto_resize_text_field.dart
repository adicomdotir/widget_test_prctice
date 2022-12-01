import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextField',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TextFieldDemo(),
    );
  }
}

class TextFieldDemo extends StatelessWidget {
  const TextFieldDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: TextField(
            minLines: 1,
            maxLines: 20,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
    );
  }
}
