import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final TriviaNumber triviaNumber;

  const TriviaDisplay({Key? key, required this.triviaNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(triviaNumber.number.toString()),
          Expanded(
            child: SingleChildScrollView(
              child: Text(triviaNumber.text),
            ),
          )
        ],
      ),
    );
  }
}
