import 'dart:async';

import 'package:challenge_evertec/features/movies/presentation/widgets/movies_categories_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _alreadyReloaded = false;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final hasInternet = results.any((r) => r != ConnectivityResult.none);

      if (hasInternet && !_alreadyReloaded) {
        _alreadyReloaded = true;
        if (!mounted) return;
        context.read<MoviesCubit>().loadInitialMovies();
      }

      if (!hasInternet) {
        _alreadyReloaded = false;
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return switch (state) {
          MoviesLoading() => const Center(child: CircularProgressIndicator()),
          MoviesLoaded(
            :final nowPlayingMovies,
            :final popularMovies,
            :final upcomingMovies,
            :final topRatedMovies,
          ) =>
            MoviesCategoriesHome(
              nowPlayingMovies: nowPlayingMovies,
              popularMovies: popularMovies,
              upcomingMovies: upcomingMovies,
              topRatedMovies: topRatedMovies,
            ),
          MoviesError(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<MoviesCubit>().loadInitialMovies();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),

          _ => const SizedBox(),
        };
      },
    );
  }
}
