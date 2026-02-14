import 'package:challenge_evertec/core/di/service_locator.dart';
import 'package:challenge_evertec/features/auth/auth.dart';
import 'package:challenge_evertec/features/home/presentation/pages/home_page.dart';
import 'package:challenge_evertec/features/movies/presentation/pages/movie_details_page.dart';
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
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home/:page',
        name: HomePage.name,
        builder: (context, state) {
          final pageIndex =
              int.tryParse(state.pathParameters['page'] ?? '0') ?? 0;
          return HomePage(pageIndex: pageIndex);
        },
        routes: [
          GoRoute(
            path: '/movie/:id',
            builder: (context, state) {
              final movieId = state.pathParameters['id']!;
              return MovieDetailsPage(movieId: movieId);
            },
          ),
        ],
      ),
    ],
  );
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authState = authCubit.state;
    final location = state.matchedLocation;
    final isAuthRoute = location == '/login' || location == '/register';
    final isSplash = location == '/splash';

    return switch (authState) {
      AuthInitial() => isSplash ? null : '/splash',
      AuthLoading() => null,
      AuthUnauthenticated() || AuthError() => isAuthRoute ? null : '/login',
      AuthAuthenticated() => isAuthRoute || isSplash ? '/home/0' : null,
      _ => null,
    };
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
