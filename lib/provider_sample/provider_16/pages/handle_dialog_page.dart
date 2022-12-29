import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/counter.dart';

class HandleDialogPage extends StatefulWidget {
  const HandleDialogPage({Key? key}) : super(key: key);

  @override
  State<HandleDialogPage> createState() => _HandleDialogPageState();
}

class _HandleDialogPageState extends State<HandleDialogPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Be careful!'),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    // if (context.watch<Counter>().counter == 3) {
    //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: Text('counter is 3'),
    //         );
    //       },
    //     );
    //   });
    // }

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (context.read<Counter>().counter == 3) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('counter is 3'),
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('HandleDialogPage'),
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
