import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import 'package:flutter/material.dart';

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
          Text(movie.overview, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text('Release Date: ${movie.releaseDate.toLocal()}'),
          const SizedBox(height: 10),
          Text('Rating: ${movie.voteAverage}'),
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
              child: Image.network(movie.posterPath, fit: BoxFit.cover),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.5],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
