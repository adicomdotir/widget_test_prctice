import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/provider_sample/provider_11/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return MaterialApp(
      title: 'Provider 11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
        title: const Text('Provider 11'),
      ),
      body: ChangeNotifierProvider<Counter>(
        create: (_) => Counter(),
        child: Center(
          child: ChildWidget(),
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Builder(
      builder: (context) {
        debugPrint('Build $runtimeType Builder');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.watch<Counter>().counter}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => context.read<Counter>().increment(),
              child: Text(
                'Increment',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
