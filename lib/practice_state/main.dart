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
      home: InheritedColor(
        child: const HomeWidget(),
        color: Colors.red,
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          NewWidget(),
          NewWidget(),
          NewWidget(),
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
