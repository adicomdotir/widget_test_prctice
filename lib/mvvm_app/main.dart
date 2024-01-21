import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const ListenableBuilderExample());
}

class CounterModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count += 1;
    Logger().d(_count);
    notifyListeners();
  }
}

class ListenableBuilderExample extends StatefulWidget {
  const ListenableBuilderExample({Key? key}) : super(key: key);

  @override
  State<ListenableBuilderExample> createState() =>
      _ListenableBuilderExampleState();
}

class _ListenableBuilderExampleState extends State<ListenableBuilderExample> {
  final CounterModel _counter = CounterModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListenableBuilder Example')),
        body: CounterBody(counterNotifier: _counter),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class CounterBody extends StatelessWidget {
  const CounterBody({Key? key, required this.counterNotifier})
      : super(key: key);

  final CounterModel counterNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Current counter value:'),
          // Thanks to the ListenableBuilder, only the widget displaying the
          // current count is rebuilt when counterValueNotifier notifies its
          // listeners. The Text widget above and CounterBody itself aren't
          // rebuilt.
          ValueListenableBuilder<CounterModel>(
            valueListenable: ValueNotifier<CounterModel>(counterNotifier),
            builder: (context, value, child) {
              Logger().d('${value.count}');
              return Text('${value.count}');
            },
          ),
          // ListenableBuilder(
          //   listenable: counterNotifier,
          //   builder: (BuildContext context, Widget? child) {
          //     return Text('${counterNotifier.count}');
          //   },
          // ),
        ],
      ),
    );
  }
}
