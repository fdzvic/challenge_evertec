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
      create: (_) => getIt<MoviesCubit>()..loadMovies(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Movies')),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {

            if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MoviesLoaded) {
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (_, i) {
                  final movie = state.movies[i];

                  return ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      width: 50,
                    ),
                    title: Text(movie.title),
                    subtitle: Text(
                      movie.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              );
            }

            if (state is MoviesError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
