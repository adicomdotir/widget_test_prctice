import 'dart:async';
import 'dart:core';

void main() async {
  await for (final name in getNames().absorbErrorsUsingHandleError()) {
    print(name);
  }

  await for (final name in getNames().absorbErrorsUsingHandlers()) {
    print(name);
  }

  await for (final name in getNames().absorbErrorsUsingTransformer()) {
    print(name);
  }
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  throw 'Error Happened';
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrorsUsingHandleError() => handleError((_) {});

  Stream<T> absorbErrorsUsingHandlers() => transform(
        StreamTransformer.fromHandlers(
          handleError: (error, stackTrace, sink) => sink.close(),
        ),
      );

  Stream<T> absorbErrorsUsingTransformer() => transform(
        StreamErrorAbsorber(),
      );
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    stream.listen(
      controller.sink.add,
      onError: (_) {},
      onDone: controller.close,
    );

    return controller.stream;
  }
}
