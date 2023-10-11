import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'core/utils/constants.dart';
import 'core/utils/router.dart';
import 'core/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();
  runApp(const CleanArchitectureWithBloc());
}

class CleanArchitectureWithBloc extends StatelessWidget {
  const CleanArchitectureWithBloc({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'clean architecture with bloc',
      theme: CustomTheme.mainTheme,
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: LOGIN_ROUTE,
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
