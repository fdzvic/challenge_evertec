import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movies_horizontal_listview.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movies_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/design/molecules/molecules.dart';
import '../cubit/movies_cubit.dart';

class MoviesCategoriesHome extends StatelessWidget {
  const MoviesCategoriesHome({super.key, required this.nowPlayingMovies, required this.popularMovies});

  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> popularMovies;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(floating: true, title: const EvAppBar()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children: [
                MoviesSlider(movies: nowPlayingMovies.sublist(0, 6)),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesNowPlaying(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Próximamente',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesNowPlaying(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesPopular(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Mejor calificadas',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesNowPlaying(),
                ),
              ],
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
