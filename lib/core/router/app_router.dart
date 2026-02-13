import 'package:challenge_evertec/core/di/service_locator.dart';
import 'package:challenge_evertec/features/auth/auth.dart';
import 'package:challenge_evertec/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthCubit authCubit = getIt<AuthCubit>();

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: _handleRedirect,
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authState = authCubit.state;
    final currentRoute = state.matchedLocation;
    final isAuthRoute = currentRoute == '/login' || currentRoute == '/register';

    return switch (authState) {
      AuthInitial() => currentRoute == '/splash' ? null : '/splash',
      AuthLoading() => null,
      AuthUnauthenticated() || AuthError() => isAuthRoute ? null : '/login',
      AuthAuthenticated() => currentRoute == '/home' ? null : '/home',
      _ => null,
    };
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
