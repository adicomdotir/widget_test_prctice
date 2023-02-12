import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipPath(
                clipper: MyClipper(status: ClipperPosition.topLeft),
                child: Container(
                  color: Colors.redAccent,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: MyClipper(status: ClipperPosition.topRight),
                child: Container(
                  color: Colors.blueAccent,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: ClipPath(
                clipper: MyClipper(status: ClipperPosition.bottomLeft),
                child: Container(
                  color: Colors.pinkAccent,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipPath(
                clipper: MyClipper(status: ClipperPosition.bottomRight),
                child: Container(
                  color: Colors.limeAccent,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

enum ClipperPosition {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
}

class MyClipper extends CustomClipper<Path> {
  final ClipperPosition status;

  MyClipper({
    required this.status,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    if (status == ClipperPosition.topLeft) {
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
      path.quadraticBezierTo(size.width, size.height, size.width, 0);
    }

    if (status == ClipperPosition.topRight) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.quadraticBezierTo(0, size.height, 0, 0);
    }

    if (status == ClipperPosition.bottomLeft) {
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.quadraticBezierTo(size.width, 0, 0, 0);
    }

    if (status == ClipperPosition.bottomRight) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.quadraticBezierTo(0, 0, size.width, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
