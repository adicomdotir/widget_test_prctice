import 'package:flutter/material.dart';
import 'package:widget_test_practice/provider_sample/provider_15/pages/proxy_provider_proxy_provider.dart';
import 'package:widget_test_practice/provider_sample/provider_15/pages/proxy_provider_update.dart';

import 'pages/proxy_provider_create_update.dart';
import 'pages/why_proxy_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return MaterialApp(
      title: 'Provider 14',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
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
        title: const Text('Provider 15'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WhyProxyProvider(),
                  ),
                ),
                child: const Text(
                  'Why\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProviderUpdate(),
                  ),
                ),
                child: const Text(
                  'ProxyProvider\nupdate',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProviderCreateUpdate(),
                  ),
                ),
                child: const Text(
                  'ProxyProvider\ncreate/update',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProviderProxyProvider(),
                  ),
                ),
                child: const Text(
                  'ProxyProvider\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
