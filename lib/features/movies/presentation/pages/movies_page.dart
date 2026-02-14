import 'package:challenge_evertec/features/movies/presentation/widgets/movies_categories_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesCubit>()..loadInitialMovies(),
      child: const MoviesView(),
    );
  }
}

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return switch (state) {
          MoviesLoading() => const Center(child: CircularProgressIndicator()),
          MoviesLoaded(:final nowPlayingMovies, :final popularMovies) =>
            MoviesCategoriesHome(
              nowPlayingMovies: nowPlayingMovies,
              popularMovies: popularMovies,
            ),
          MoviesError(:final message) => Center(child: Text(message)),
          _ => const SizedBox(),
        };
      },
    );
  }
}
