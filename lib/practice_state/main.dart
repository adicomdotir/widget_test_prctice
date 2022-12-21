import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$runtimeType build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterInherited(
        child: const HomeWidget(),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$runtimeType build');
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(),
      ),
      floatingActionButton: FabWidget(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextWidget(),
          ),
        ],
      ),
    );
  }
}

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FabWidget build');
    var item = context
        .dependOnInheritedWidgetOfExactType<CounterWidget>(aspect: 2)!
        .state;
    return FloatingActionButton(
      onPressed: () {
        item.increment();
      },
      child: Icon(Icons.add),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$runtimeType build');
    var item =
        context.dependOnInheritedWidgetOfExactType<CounterWidget>()!.state;
    return Text(item.counter.toString());
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$runtimeType build');
    var item =
        context.dependOnInheritedWidgetOfExactType<CounterWidget>()!.state;
    return Text(
      'This is sample. ${item.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class CounterInherited extends StatefulWidget {
  final Widget child;
  CounterInherited({Key? key, required this.child}) : super(key: key);

  @override
  State<CounterInherited> createState() => CounterInheritedState();
}

class CounterInheritedState extends State<CounterInherited> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterWidget(
      child: widget.child,
      state: this,
    );
  }
}

class CounterWidget extends InheritedWidget {
  CounterWidget({Key? key, required this.child, required this.state})
      : super(key: key, child: child);

  final Widget child;
  final CounterInheritedState state;

  @override
  bool updateShouldNotify(CounterWidget oldWidget) {
    return true;
  }

  // @override
  // bool updateShouldNotifyDependent(
  //     covariant InheritedModel<int> oldWidget, Set<int> dependencies) {
  //   if (dependencies.contains(1)) return true;
  //   return false;
  // }
}
