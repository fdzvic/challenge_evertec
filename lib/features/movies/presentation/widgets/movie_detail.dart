import 'package:challenge_evertec/core/utils/design/design.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key, required this.movie});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomAppBar(size: size, movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _Details(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.movie});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.posterPath,
                    width: size.width * 0.3,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (size.width - 40) * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: textStyle.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Release Date: ${movie.releaseDate.toIso8601String().split('T').first}',
                        style: textStyle.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(movie.overview, style: textStyle.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genres.map(
                  (genre) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(genre.name),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({required this.size, required this.movie});

  final Size size;
  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        BlocBuilder<FavoritesCubit, FavoritesState>(
          buildWhen: (prev, curr) => curr is FavoritesLoaded,
          builder: (context, state) {
            bool isFavorite = false;

            if (state is FavoritesLoaded) {
              isFavorite = state.favorites.any(
                (fav) => fav.movieId == movie.id,
              );
            }
            return IconButton(
              onPressed: () async {
                final added = await context
                    .read<FavoritesCubit>()
                    .toggleFavorite(
                      movieId: movie.id,
                      title: movie.title,
                      posterPath: movie.posterPath,
                      backdropPath: movie.posterPath,
                      originalTitle: movie.title,
                      voteAverage: movie.voteAverage,
                    );

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      added
                          ? 'Añadida a favoritos ❤️'
                          : 'Eliminada de favoritos 💔',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                  key: ValueKey(isFavorite),
                  color: isFavorite ? Colors.red : Colors.white,
                ),
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(10),
        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/placeholder.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const EvGradient(begin: Alignment.topLeft),
            const EvGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ],
        ),
      ),
    );
  }
}
