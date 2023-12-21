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
    print(runtimeType);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: BlocBuilder<CustomBloc, CustomState>(
              builder: (context, state) {
                print(state.runtimeType);
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
        Expanded(
          child: Center(
            child: UpdateCounterState(
              child: Builder(
                builder: (context) {
                  final counter = CounterInheritedWidget.of(context)?.counter;

                  return GestureDetector(
                    onTap: () {
                      CounterInheritedWidget.of(context)?.increament();
                    },
                    child: Text(counter.toString()),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final _UpdateCounterState updateCounterState;

  const CounterInheritedWidget({
    Key? key,
    required Widget child,
    required this.counter,
    required this.updateCounterState,
  }) : super(key: key, child: child);

  static _UpdateCounterState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()
        ?.updateCounterState;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) =>
      oldWidget.counter != counter;
}

class UpdateCounterState extends StatefulWidget {
  final Widget child;
  const UpdateCounterState({required this.child, Key? key}) : super(key: key);

  @override
  State<UpdateCounterState> createState() => _UpdateCounterState();
}

class _UpdateCounterState extends State<UpdateCounterState> {
  int counter = 0;

  void increament() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      counter: counter,
      updateCounterState: this,
      child: widget.child,
    );
  }
}
