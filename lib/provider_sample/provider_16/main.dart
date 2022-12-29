import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/provider_sample/provider_16/pages/counter_page.dart';
import 'package:widget_test_practice/provider_sample/provider_16/pages/handle_dialog_page.dart';
import 'package:widget_test_practice/provider_sample/provider_16/pages/navigate_page.dart';
import 'providers/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MaterialApp(
        title: 'Provider 16',
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
        title: const Text('Provider 16'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CounterPage(),
                  ),
                ),
                child: const Text(
                  'Counter Page',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HandleDialogPage(),
                  ),
                ),
                child: const Text(
                  'Handle Dialog Page',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NavigatePage(),
                  ),
                ),
                child: const Text(
                  'Navigate Page',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
