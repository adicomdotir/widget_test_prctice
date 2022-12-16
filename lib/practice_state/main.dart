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
      home: CounterInherited(
        child: InheritedColor(
          child: const HomeWidget(),
          color: Colors.red,
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counterInherited = CounterWidget.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(counterInherited.counter.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterInherited.increment();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          NewWidget(),
          NewWidget(),
          NewWidget(),
          Text('${counterInherited.counter}'),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = InheritedColor.of(context);
    return Text(
      'This is sample.',
      style: TextStyle(color: color.color),
    );
  }
}

class InheritedColor extends InheritedWidget {
  final Color color;

  InheritedColor({required Widget child, required this.color})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedColor oldWidget) {
    return color == oldWidget.color;
  }

  static InheritedColor of(BuildContext context) {
    var color = context.dependOnInheritedWidgetOfExactType<InheritedColor>();
    assert(color != null);
    return color!;
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

  static CounterInheritedState of(BuildContext context) {
    var result = context.dependOnInheritedWidgetOfExactType<CounterWidget>();
    assert(result != null);
    return result!.state;
  }

  @override
  bool updateShouldNotify(CounterWidget oldWidget) {
    return true;
  }
}
