import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.red.withOpacity(.8),
                height: 220,
                alignment: Alignment.center,
              ),
            ),
            ClipPath(
              clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
              child: Container(
                padding: const EdgeInsets.only(bottom: 50),
                color: Colors.blue.withOpacity(.3),
                height: 180,
                alignment: Alignment.center,
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

class WaveClipper extends CustomClipper<Path> {
  final double waveDeep;
  final double waveDeep2;

  WaveClipper({
    this.waveDeep = 100,
    this.waveDeep2 = 0,
  });

  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;

    final Offset controlPoint1 = Offset(sw * .25, sh - waveDeep2 * 2);
    final Offset destinationPoint1 = Offset(sw * .5, sh - waveDeep - waveDeep2);

    final Offset controlPoint2 = Offset(sw * .75, sh - waveDeep * 2);
    final Offset destinationPoint2 = Offset(sw, sh - waveDeep);

    final Path path = Path()
      ..lineTo(0, size.height - waveDeep2)
      ..quadraticBezierTo(
        controlPoint1.dx,
        controlPoint1.dy,
        destinationPoint1.dx,
        destinationPoint1.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        destinationPoint2.dx,
        destinationPoint2.dy,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
