import 'package:challenge_evertec/core/di/service_locator.dart';
import 'package:challenge_evertec/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:challenge_evertec/features/auth/presentation/cubit/auth_state.dart';
import 'package:challenge_evertec/features/favorites/presentation/pages/favorite_page.dart';
import 'package:challenge_evertec/features/home/presentation/widgets/custom_botton_navigation_bar.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/pages/movies_page.dart';
import 'package:challenge_evertec/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:challenge_evertec/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.childView});

  final Widget childView;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
        body: widget.childView,
        bottomNavigationBar: const CustomBottonNavigatorBar(),
      ),
    );
  }
}

