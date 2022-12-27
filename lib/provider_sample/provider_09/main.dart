import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return MaterialApp(
      title: 'Provider 09',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Foo with ChangeNotifier {
  String value = 'Foo';

  Foo();

  void changeValue() {
    value = value == 'Foo' ? 'Baz' : 'Foo';
    notifyListeners();
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
        title: const Text('Provider 09'),
      ),
      body: ChangeNotifierProvider<Foo>(
        create: (_) => Foo(),
        child: Consumer<Foo>(
          builder: (context, Foo foo, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    foo.value,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => foo.changeValue(),
                    child: Text(
                      'Change Value',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // builder: (context, child) {
        //   return Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           context.watch<Foo>().value,
        //           style: TextStyle(
        //             fontSize: 40,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         ElevatedButton(
        //           onPressed: ()=> context.read<Foo>().changeValue(),
        //           child: Text(
        //             'Change Value',
        //             style: TextStyle(
        //               fontSize: 20.0,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // },
      ),
    );
  }
}
