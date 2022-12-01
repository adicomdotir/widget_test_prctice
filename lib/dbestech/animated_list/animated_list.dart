import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test_practice/dbestech/custom_appbar_reusable_widget/custom_app_bar.dart';
import 'package:widget_test_practice/dbestech/custom_appbar_reusable_widget/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addItem() {
    _items.insert(0, 'Item ${_items.length + 1}');
    _key.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            color: Colors.purple,
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                'Removing',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 500),
    );
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: AnimatedList(
        key: _key,
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              color: Colors.blue,
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title: Text(
                  _items[index],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent.withOpacity(0.9),
                  ),
                  onPressed: () =>  _removeItem(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
