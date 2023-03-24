import 'dart:math' as Math;

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: NewWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text('upper'),
        ),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              height: 120,
              color: Colors.amber,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  color: Colors.redAccent,
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
      child: InkWell(
        splashColor: Colors.yellow,
        child: Container(
          width: (width - parentPadding * 2) * 0.2 - parentPadding,
          height: (width - parentPadding * 2) * 0.2 - parentPadding,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          child: Icon(Icons.add),
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
