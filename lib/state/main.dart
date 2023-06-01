import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build $runtimeType');
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigation(),
    );
  }
}

// route function for  Routing of pages
Route generatePage(child) {
  return MaterialPageRoute(builder: (context) => child);
}

class MyNavigation extends StatelessWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build $runtimeType');
    return StateContainer(
      child: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'screen1':
              // Route for firs screen
              return generatePage(const FirstScreen());
            case 'screen2':
              // Route for second screen
              return generatePage(const SecondScreen());
          }
        },
        // our first screen in app
        initialRoute: 'screen1',
      ),
    );
  }
}

class StateContainer extends StatefulWidget {
  final Widget child;

  const StateContainer({
    required this.child,
  });

  static StateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>()
            as _MyInheritedWidget)
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  final _carts = <String>[];

  void addToCart(String id) {
    setState(() {
      _carts.add(id);
    });
  }

  void deleteCart(String cart) {
    setState(() {
      _carts.remove(cart);
    });
  }

  List<String> getCarts() => _carts;

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  final StateContainerState data;

  const _MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build $runtimeType');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'screen2');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: ListView(
        children: List.generate(
          10,
          (index) => Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product $index'),
                IconButton(
                  onPressed: () {
                    StateContainer.of(context).addToCart('Product $index');
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build $runtimeType');
    var carts = StateContainer.of(context).getCarts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: List.generate(
          carts.length,
          (index) => Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(carts[index]),
                IconButton(
                  onPressed: () {
                    StateContainer.of(context).deleteCart(carts[index]);
                  },
                  icon: const Icon(Icons.delete_forever),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
