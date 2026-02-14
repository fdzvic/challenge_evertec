import 'package:challenge_evertec/features/movies/presentation/widgets/movies_categories_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

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
          MoviesError(:final message) => Center(child: Text(message)),
          _ => const SizedBox(),
        };
      },
    );
  }
}
