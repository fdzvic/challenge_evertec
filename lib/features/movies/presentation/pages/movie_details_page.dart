import 'package:challenge_evertec/core/di/service_locator.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieDetailCubit>()..loadMovieDetails(movieId),
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          return switch (state) {
            MovieDetailLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            MovieDetailLoaded(:final movie) => MovieDetail(movie: movie),
            MovieDetailError(:final message) => Scaffold(
              body: Center(child: Text(message)),
            ),
            _ => const Scaffold(body: SizedBox()),
          };
        },
      ),
    );
  }
}
