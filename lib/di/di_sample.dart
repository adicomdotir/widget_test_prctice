import 'package:widget_test_practice/common/log_extension.dart';
import 'package:logger/logger.dart';

class StringStackTrace implements StackTrace {
  final String _stackTrace;

  const StringStackTrace(this._stackTrace);

  @override
  String toString() => _stackTrace;
}

class DIHelper {
  static final DIHelper _instance = DIHelper._internal();
  DIHelper._internal();
  factory DIHelper() => _instance;

  final Map<Type, dynamic> _dependencies = {};
  final Map<Type, dynamic Function()> _lazyDependencies = {};

  void regitster<T>(T dependency) {
    _dependencies[T] = dependency;
  }

  void lazyRegitster<T>(dynamic Function() dependency) {
    _lazyDependencies[T] = dependency;
  }

  T resolve<T>() {
    if (!_dependencies.containsKey(T)) {
      throw ArgumentError('No dependency registered for $T');
    }
    return _dependencies[T];
  }

  T resolveLazy<T>() {
    if (!_lazyDependencies.containsKey(T)) {
      throw ArgumentError('No dependency registered for $T');
    }
    return _lazyDependencies[T]!();
  }
}

class MyColor {
  MyColor() {
    Logger().log(
      Level.verbose,
      'MyColor  .....',
      'An Error',
      const StringStackTrace('Your stacktrace here'),
    );
    print('MyColor  .....');
  }
}

class MyConfig {
  MyConfig() {
    print('MyConfig  .....');
  }
}

void main() {
  print('1');
  DIHelper().regitster<MyColor>(MyColor());
  print('2');
  DIHelper().lazyRegitster<MyConfig>(() => MyConfig());
  print('3');
  print(DIHelper().resolve<MyColor>());
  print('4');
  print(DIHelper().resolveLazy<MyConfig>());
}
