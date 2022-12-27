import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Translations {
  final int _value;

  const Translations(this._value);

  String get title => 'You clicked $_value times';
}

class ProxyProviderUpdate extends StatefulWidget {
  const ProxyProviderUpdate({Key? key}) : super(key: key);

  @override
  State<ProxyProviderUpdate> createState() => _ProxyProviderUpdateState();
}

class _ProxyProviderUpdateState extends State<ProxyProviderUpdate> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
      print('counter: $counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProxyProvider Update'),
      ),
      body: Center(
        child: ProxyProvider0<Translations>(
          update: (_, __) => Translations(counter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ShowTranslations(),
              const SizedBox(height: 20.0),
              IncreaseButton(increment: increment)
            ],
          ),
        ),
      ),
    );
  }
}

class ShowTranslations extends StatelessWidget {
  const ShowTranslations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    final title = Provider.of<Translations>(context).title;
    return Text(
      title,
      style: const TextStyle(fontSize: 28.0),
    );
  }
}

class IncreaseButton extends StatelessWidget {
  final void Function() increment;

  const IncreaseButton({Key? key, required this.increment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return ElevatedButton(
      onPressed: increment,
      child: Text(
        'increase'.toUpperCase(),
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
