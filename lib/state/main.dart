import 'package:flutter/material.dart';
import 'package:widget_test_practice/provider_sample/provider_17/app_provider.dart';

class AppDataProvider extends InheritedWidget {
  AppDataProvider({
    Key? key,
    required this.child,
    required this.appData,
  }) : super(key: key, child: child);

  @override
  // ignore: overridden_fields
  final Widget child;
  final AppData appData;
  int counter = 0;

  incrementCounter() {
    counter++;
  }

  static AppDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDataProvider>();
  }

  @override
  bool updateShouldNotify(AppDataProvider oldWidget) {
    print('object');
    return true;
  }
}

class AppData {
  int count;

  AppData({required this.count});

  incrementCount() {
    count += 1;
  }
}

void main(List<String> args) {
  runApp(AppDataProvider(child: const MyApp(), appData: AppData(count: 5)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppDataProvider.of(context)!.appData.count.toString(),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppDataProvider.of(context)!.counter.toString(),
              style: ThemeData.light().textTheme.headline3,
            ),
            Text(
              AppDataProvider.of(context)!.appData.count.toString(),
              style: ThemeData.light().textTheme.headline3,
            ),
            ElevatedButton(
              onPressed: () {
                AppDataProvider.of(context)?.appData.incrementCount();
                AppDataProvider.of(context)!.incrementCounter();
                setState(() {});
              },
              child: const Text('Increment'),
            )
          ],
        ),
      ),
    );
  }
}
