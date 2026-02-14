import 'package:challenge_evertec/core/di/service_locator.dart';
import 'package:challenge_evertec/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:challenge_evertec/features/auth/presentation/cubit/auth_state.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/pages/movies_page.dart';
import 'package:challenge_evertec/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:challenge_evertec/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/favorites_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    MoviesPage(),
    FavoritesTab(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MoviesCubit>()..loadInitialMovies()),
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..loadProfile(authState.user.id),
        ),
      ],
      child: Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
