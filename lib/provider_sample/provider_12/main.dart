import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/provider_sample/provider_12/counter.dart';
import 'package:widget_test_practice/provider_sample/provider_12/show_me_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return MaterialApp(
      title: 'Provider 12',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<Counter>(
        create: (_) => Counter(),
        child: const MyHomePage(),
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
        title: const Text('Provider 12'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return ChangeNotifierProvider.value(
                        value: context.read<Counter>(),
                        child: ShowMeCounter(),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Show Me Counter',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => context.read<Counter>().increment(),
              child: Text(
                'Increment Counter',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
