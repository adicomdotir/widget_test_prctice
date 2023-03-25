import 'dart:math' as Math;

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: const NewWidget(),
      ),
    ),
  );
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  List<int> temps = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: temps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(temps[index].toString()),
                subtitle: Text(temps[index].toString()),
              );
            },
          ),
        ),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 120,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            customFabButton(context, parentPadding: 8),
          ],
        ),
      ],
    );
  }

  Positioned customFabButton(
    BuildContext context, {
    required double parentPadding,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: parentPadding + parentPadding / 2,
      left:
          (width - parentPadding * 2) * 0.4 + parentPadding + parentPadding / 2,
      child: Container(
        width: (width - parentPadding * 2) * 0.2 - parentPadding,
        height: (width - parentPadding * 2) * 0.2 - parentPadding,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
        ),
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.green,
            onTap: () {
              int rnd = Math.Random().nextInt(9999);
              temps.add(rnd);
              setState(() {});
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.width * 0.2 / 2);
    path.lineTo(size.width * 0.4, size.width * 0.2 / 2);
    path.arcTo(
      Rect.fromLTWH(size.width * 0.4, 0, size.width * 0.2, size.width * 0.2),
      180 * Math.pi / 180,
      -180 * Math.pi / 180,
      true,
    );
    path.lineTo(size.width * 0.6, size.width * 0.2 / 2);
    path.lineTo(size.width, size.width * 0.2 / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.width * 0.2 / 2);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
