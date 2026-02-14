import 'package:challenge_evertec/core/utils/helpers/human_formats.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatelessWidget {
  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  final List<MovieEntity> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) => _Slide(movie: movies[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: titleStyle),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subtitle!),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return FadeInImage(
                    placeholder: const AssetImage(
                      'assets/images/placeholder.jpg',
                    ),
                    image: NetworkImage(movie.posterPath),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: textStyle.bodyMedium?.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '(${HumanFormats.numberFromString(movie.popularity)})',
                  style: textStyle.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
