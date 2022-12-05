import 'package:flutter/material.dart';

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
        primarySwatch: Colors.green,
        fontFamily: 'Lato',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RatingBar(
          rating: 3.5,
          ratingCount: 12,
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final double size;

  const RatingBar({
    Key? key,
    required this.rating,
    required this.ratingCount,
    this.size = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(
          Icon(
            Icons.star,
            color: Theme.of(context).primaryColor,
            size: size,
          ),
        );
      } else if (i == realNumber) {
        _starList.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
                ClipRect(
                  clipper: _Clipper(part: partNumber),
                  child: Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: size,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        _starList.add(
          Icon(
            Icons.star,
            color: Colors.grey,
            size: size,
          ),
        );
      }
    }

    _starList.add(
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          '($ratingCount)',
          style: TextStyle(
            fontSize: size * 0.8,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      size.width / 10 * part,
      0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
