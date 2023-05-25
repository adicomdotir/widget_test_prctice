import 'package:go_router/go_router.dart';

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [],
    );
  }
}
