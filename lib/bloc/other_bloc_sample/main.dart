import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class CounterBloc {
  // this sink is the 'input'.
  // sinks should be the _only_ way that
  // outside object can interact with blocs.
  StreamController<int> todoCompleteSink = StreamController();

  // this stream is the 'output'
  // it's the only property that outside
  // objects can use to consume this blocs data.
  Stream<int> get todoCompleteStream => todoCompleteSink.stream;

  CounterBloc() {
    todoCompleteSink.add(0);
  }

  dispose() {
    todoCompleteSink.close();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CounterBloc bloc = CounterBloc();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      // here the bloc data is being consumed by the UI
      stream: bloc.todoCompleteStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            // here the sink is being used to tell
            // the bloc it should update it's state
            onPressed: () => bloc.todoCompleteSink.add(snapshot.data! + 1),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
