import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test_practice/ui_tutorials/temprature_slider/thermo.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: TemperatureView(),
    );
  }
}

class TemperatureView extends StatelessWidget {
  final ValueNotifier<double> temperature = ValueNotifier(20.0);

  TemperatureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: ValueListenableBuilder(
          valueListenable: temperature,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('${temperature.value.toInt()}'),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.loose(
                          const Size(400, 800),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                color: Colors.amberAccent,
                                child: Thermo(
                                  temperature: temperature.value,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              left: 300,
                              child: Container(
                                color: Colors.redAccent,
                                child: Text('2'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
