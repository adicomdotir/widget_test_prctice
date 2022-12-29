import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/counter.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<Counter>().counter == 3) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => OtherPage()));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigatePage'),
      ),
      body: Center(
        child: Text(
          '${context.watch<Counter>().counter}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<Counter>().increment();
        },
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Page'),
      ),
      body: const Center(
        child: Text(
          'other',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
