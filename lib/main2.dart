import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Expanded(child: Text('Other')),
        Container(
          height: size.height * 0.15,
          color: Colors.purple.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemWidget(
                width: size.width * 0.20,
                left: false,
                right: true,
                isDone: true,
              ),
              ItemWidget(
                width: size.width * 0.20,
                left: true,
                right: true,
                isDone: true,
              ),
              ItemWidget(
                width: size.width * 0.20,
                left: true,
                right: true,
                isDone: true,
              ),
              ItemWidget(
                width: size.width * 0.20,
                left: true,
                right: true,
                isDone: false,
              ),
              ItemWidget(
                width: size.width * 0.20,
                left: true,
                right: false,
                isDone: false,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {
  final double width;
  final bool left;
  final bool right;
  final bool isDone;
  const ItemWidget({
    Key? key,
    required this.width,
    required this.left,
    required this.right,
    required this.isDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            height: 70,
            child: Stack(
              children: [
                Positioned(
                  top: 32,
                  left: left ? 0 : (width / 2),
                  child: Container(
                    width: (left && right) ? width : width / 2,
                    height: 6,
                    color: isDone ? Colors.green : Colors.grey,
                  ),
                ),
                Positioned(
                  left: width / 2 - 20,
                  top: 15,
                  child: CircleAvatar(
                    backgroundColor: isDone ? Colors.green : Colors.grey,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.handyman_outlined),
                  ),
                ),
                Positioned(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.done,
                        size: 15,
                      ),
                    ),
                  ),
                  top: 5,
                  right: width / 2 - 10 - 20,
                )
              ],
            ),
          ),
          const Text(
            'Awaiting Deposit',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
