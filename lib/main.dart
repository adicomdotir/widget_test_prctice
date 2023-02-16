import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: CardListScreen(),
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

var items = [
  Item(
    'Triangle',
    'assets/travel_booking_app/images/travlog_yogyakarta.png',
    'The image is down pointed traingle',
    ClipType.traingle,
  ),
  Item(
    'Arc',
    'assets/travel_booking_app/images/travlog_yogyakarta.png',
    'The bottom edge of the above edge is arc-shaped',
    ClipType.arc,
  ),
  Item(
    'Pointed Edge multiple ',
    'assets/travel_booking_app/images/travlog_yogyakarta.png',
    'The bottom edge of the above image is multiple pointed.',
    ClipType.pointed,
  ),
  Item(
    'Rounded multiple curve',
    'assets/travel_booking_app/images/travlog_yogyakarta.png',
    'The bottom edge of the above image is multiple rounded',
    ClipType.curved,
  ),
  Item(
    'Rounded multiple curve',
    'assets/travel_booking_app/images/travlog_yogyakarta.png',
    'The bottom edge of the above image is wave',
    ClipType.waved,
  )
];

class Item {
  final name;
  final image;
  final description;
  final clipType;

  Item(this.name, this.image, this.description, this.clipType);
}

class CardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: ListView(
          children: items.map((item) => createClippedWidget(item)).toList(),
        ),
      ),
    );
  }

  Widget createClippedWidget(Item item) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(16),
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ZigZag(
            clipType: item.clipType,
            child: Image.asset(
              item.image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.name,
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
            child: Text(
              item.description,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}

enum ClipType { pointed, curved, arc, traingle, waved }

class ZigZag extends StatelessWidget {
  Widget child;
  ClipType clipType;

  ZigZag({required this.child, this.clipType = ClipType.curved});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ZigZagClipper(clipType),
      child: child,
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  ClipType clipType;

  ZigZagClipper(this.clipType);

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (clipType == ClipType.pointed) {
      createPointedTraingle(size, path);
    } else if (clipType == ClipType.arc) {
      createBeziarArc(size, path);
    } else if (clipType == ClipType.traingle) {
      createTriangle(size, path);
    } else if (clipType == ClipType.waved) {
      createWave(size, path);
    } else {
      createCurve(size, path);
    }

    path.close();
    return path;
  }

  createTriangle(Size size, Path path) {
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
  }

  createArc(Size size, Path path) {
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: const Radius.elliptical(30, 10),
    );
    path.lineTo(size.width, 0);
  }

  createBeziarArc(Size size, Path path) {
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 100,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
  }

  createCurve(Size size, Path path) {
    path.lineTo(0, size.height);

    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(
        Offset(curXPos, curYPos),
        radius: const Radius.circular(5),
      );
    }
    path.lineTo(size.width, 0);
  }

  createPointedTraingle(Size size, Path path) {
    path.lineTo(0, size.height);

    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 30 : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
  }

  createWave(Size size, Path path) {
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 4,
      size.height - 40,
      size.width / 2,
      size.height - 20,
    );
    path.quadraticBezierTo(
      3 / 4 * size.width,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
