import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/bloc/multi_bloc_sample/bloc/CountStatus.dart';
import 'package:widget_test_practice/bloc/multi_bloc_sample/bloc/custom_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<CustomBloc>(
          create: (context) => CustomBloc(),
          child: const MyScreen(),
        ),
      ),
    );
  }
}

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: BlocBuilder<CustomBloc, CustomState>(
              builder: (context, state) {
                if (state.countStatus1 is CountStatusCompleted) {
                  final castState = state.countStatus1 as CountStatusCompleted;
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<CustomBloc>(context)
                          .add(CustomEvent1(castState.count));
                    },
                    child: Text(castState.count.toString()),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<CustomBloc, CustomState>(
              builder: (context, state) {
                if (state.countStatus2 is CountStatusCompleted) {
                  final castState = state.countStatus2 as CountStatusCompleted;
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<CustomBloc>(context)
                          .add(CustomEvent2(castState.count));
                    },
                    child: Text(castState.count.toString()),
                  );
                } else if (state.countStatus2 is CountStatusError) {
                  final castState = state.countStatus2 as CountStatusError;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(castState.message.toString()),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<CustomBloc>(context)
                              .add(ResetEvent());
                        },
                        child: const Text('Reset'),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<CustomBloc, CustomState>(
              builder: (context, state) {
                return Text(state.messageStatus.message);
              },
            ),
          ),
        ),
        const Expanded(child: Center(child: Text('4'))),
      ],
    );
  }
}
