import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({super.key, required this.movies});
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.movie});
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.backdropPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
