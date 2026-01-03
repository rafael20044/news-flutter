import 'package:go_router/go_router.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/features/home/home_screen.dart';
import 'package:news/features/login/login_screen.dart';

class AppRouter {
  static final _router = GoRouter(
    redirect: (context, state) async {
      final logged = await AuthService.isLogged();
      if (!logged && state.matchedLocation != '/login') {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    ],
  );

  static GoRouter getRouter() {
    return _router;
  }
}
