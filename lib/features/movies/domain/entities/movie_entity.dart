class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double rating;
  final String backdropPath;
  final bool adult;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.rating,
    required this.backdropPath,
    required this.adult,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
