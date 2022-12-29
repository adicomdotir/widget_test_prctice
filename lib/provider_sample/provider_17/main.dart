import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/provider_sample/provider_17/app_provider.dart';
import 'package:widget_test_practice/provider_sample/provider_17/success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'Provider 17',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final AppProvider appProvider;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? searchTerm;

  @override
  void initState() {
    super.initState();
    appProvider = context.read<AppProvider>();
    appProvider.addListener(addListener);
  }

  @override
  void dispose() {
    appProvider.removeListener(addListener);
    super.dispose();
  }

  void addListener() {
    if (appProvider.state == AppState.success) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SuccessPage()));
    } else if (appProvider.state == AppState.error) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  void submit() async {
    setState(() {
      autoValidateMode = AutovalidateMode.always;
    });

    final form = formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    await context.read<AppProvider>().getResult(searchTerm!);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build $runtimeType');
    final appState = context.watch<AppProvider>().state;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Search'),
                    prefixIcon: Icon(Icons.search),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Search term required';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    searchTerm = newValue;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: appState == AppState.loading ? null : submit,
                  child: Text(
                    appState == AppState.loading ? 'Loading...' : 'Get Result',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
