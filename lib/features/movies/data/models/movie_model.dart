import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.rating,
    required super.backdropPath,
    required super.adult,
    required super.genreIds,
    required super.originalLanguage,
    required super.originalTitle,
    required super.popularity,
    required super.releaseDate,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] != null && json['poster_path'] != ''
          ? 'https://image.tmdb.org/t/p/w200${json['poster_path']}'
          : 'https://ih1.redbubble.net/image.533910704.5853/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg',
      rating: (json['vote_average'] as num).toDouble(),
      backdropPath: json['backdrop_path'] != null && json['backdrop_path'] != ''
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://ih1.redbubble.net/image.533910704.5853/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg',
      adult: json['adult'] ?? false,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      popularity: json['popularity'] ?? 0.0,
      releaseDate: json['release_date'] != null ? DateTime.parse(json['release_date']) : DateTime.now(),
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
