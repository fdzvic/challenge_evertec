import 'dart:developer';

import 'package:challenge_evertec/core/utils/design/design.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movies_horizontal_listview.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movies_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCategoriesHome extends StatelessWidget {
  const MoviesCategoriesHome({
    super.key,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.upcomingMovies,
    required this.topRatedMovies,
  });

  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> upcomingMovies;
  final List<MovieEntity> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          title: EvAppBar(
            title: 'Peliculas',
            icon: Icons.movie,
            onSearchPressed: () {
              log('Buscando...');
            },
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children: [
                MoviesSlider(movies: nowPlayingMovies.sublist(0, 6)),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesNowPlaying(),
                ),
                MoviesHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesUpcoming(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesPopular(),
                ),
                MoviesHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  loadNextPage: () =>
                      context.read<MoviesCubit>().loadMoreMoviesTopRated(),
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
