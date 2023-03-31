import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/widgets/trivia_desplay.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(
                      message: 'Start searching',
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(triviaNumber: state.trivia);
                  } else if (state is ErrorState) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else {
                    return const Placeholder();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
