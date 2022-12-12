import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool showIcon = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.isCompleted) {
            showIcon = false;
          }
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform And Rotate'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showIcon = true;
              });
            },
            icon: const Icon(Icons.restart_alt),
          )
        ],
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: showIcon
              ? Transform(
                  transform: Matrix4.rotationZ(math.pi / 180 * animation.value),
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      if (showIcon) {
                        setState(() {
                          controller.reset();
                          controller.forward();
                        });
                      }
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 40,
                    color: Colors.red,
                  ),
                )
              : const Text('Welcome'),
        ),
      ),
    );
  }
}
