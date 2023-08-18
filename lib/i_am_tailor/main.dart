import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:widget_test_practice/i_am_tailor/add_edit_customer_screen.dart';
import 'package:widget_test_practice/i_am_tailor/customer_detail_screen.dart';
import 'package:widget_test_practice/i_am_tailor/customer_info.dart';
import 'package:widget_test_practice/i_am_tailor/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CustomerInfoAdapter());
  await Hive.openBox<CustomerInfo>('customers');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(fontFamily: 'Vazir'),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CustomerInfo> customers = MyDatabase.getInstance().fetchCustomers();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست افراد'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddEditCustomerScreen(),
            ),
          )
              .then((value) {
            customers = MyDatabase.getInstance().fetchCustomers();
            setState(() {});
          });
        },
      ),
      body: customers.isNotEmpty
          ? ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CustomerDetailScreen(
                          customerInfo: customer,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(customer.name ?? ''),
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('دیتا وجود ندارد'),
            ),
    );
  }
}
