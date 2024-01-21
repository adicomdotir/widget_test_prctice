import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:widget_test_practice/hive_samples/sample_01/person.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  print('init');
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(ShoppingItemAdapter());
  print(Hive.isAdapterRegistered(0));
  // await Hive.openBox('shopping_box');
  await Hive.openBox<ShoppingItem>('shopping_v2_box');

  // upgrade version db
  // final oldBox = Hive.box('shopping_box');
  // final newBox = Hive.box<ShoppingItem>('shopping_v2_box');
  // for (var oldBoxItem in oldBox.values) {
  //   newBox.add(
  //     ShoppingItem()
  //       ..name = oldBoxItem['name']
  //       ..quantity = oldBoxItem['quantity'],
  //   );
  // }
  // if (oldBox.values.length == newBox.values.length) {
  //   oldBox.deleteFromDisk();
  // }

  LazyBox<Person> box = await Hive.openLazyBox<Person>('person');
  // print('open');
  // final person = Person()..name = 'John';
  // await box.put('person', person);
  // print(await box.get('person'));

  // Box<Person> box = await Hive.openBox<Person>('person');
  print('open ${box.isOpen}');
  final person = Person()..name = 'John';
  if (box.keys.length < 10) {
    box.add(person);
  }
  print('Length: ${box.keys.length}');
  for (var item in box.keys) {
    print('Key: $item');
  }
  await box.delete('person');
  box.close();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [];

  final _shoppingBox = Hive.box<ShoppingItem>('shopping_v2_box');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    // Set<int> mySet = <int>{};
    // for (int i = 0; i < 100000; i++) {
    //   final uk = UniqueKey();
    //   int id = uk.hashCode;
    //   mySet.add(id);
    // }
    // print('Length: ${mySet.length}');

    final data = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key);
      return {'key': key, 'name': value?.name, 'quantity': value?.quantity};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  // Create new item
  Future<void> _createItem(ShoppingItem newItem) async {
    await _shoppingBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  ShoppingItem _readItem(int key) {
    final item = _shoppingBox.get(key);
    return item!;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, ShoppingItem item) async {
    await _shoppingBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _shoppingBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An item has been deleted')),
    );
  }

  // TextFields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'];
    }

    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Quantity'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new item
                if (itemKey == null) {
                  final item = ShoppingItem()
                    ..name = _nameController.text
                    ..quantity = _quantityController.text;
                  _createItem(item);
                }

                // update an existing item
                if (itemKey != null) {
                  final item = ShoppingItem()
                    ..name = _nameController.text.trim()
                    ..quantity = _quantityController.text.trim();
                  _updateItem(itemKey, item);
                }

                // Clear the text fields
                _nameController.text = '';
                _quantityController.text = '';

                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child: Text(itemKey == null ? 'Create New' : 'Update'),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KindaCode.com'),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: Colors.orange.shade100,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(currentItem['name']),
                    subtitle: Text(currentItem['quantity'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit button
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showForm(context, currentItem['key']),
                        ),
                        // Delete button
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(currentItem['key']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
