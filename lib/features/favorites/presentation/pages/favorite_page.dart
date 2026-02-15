import 'package:challenge_evertec/core/utils/design/design.dart';
import 'package:challenge_evertec/core/utils/ui/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text('No tienes películas favoritas'));
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    EvAppBar(
                      title: 'Favoritos',
                      icon: Icons.favorite,
                      onSearchPressed: () => showFeatureNotAvailable(context),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          final movie = state.favorites[index];

                          return GestureDetector(
                            onTap: () =>
                                context.push('/home/0/movie/${movie.movieId}'),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      movie.posterPath,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                                'assets/images/placeholder.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                    ),
                                  ),
                                  const EvGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final removed = await context
                                          .read<FavoritesCubit>()
                                          .toggleFavorite(
                                            movieId: movie.movieId,
                                            title: movie.title,
                                            posterPath: movie.posterPath,
                                            backdropPath: movie.backdropPath,
                                            originalTitle: movie.originalTitle,
                                            voteAverage: movie.voteAverage,
                                          );

                                      if (!context.mounted) return;

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            removed
                                                ? 'Agregado a favoritos'
                                                : 'Eliminado de favoritos',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.black,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
