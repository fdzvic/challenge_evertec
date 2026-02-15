import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';

class MovieDetailModel extends MovieDetailsEntity {
  MovieDetailModel({
    required super.adult,
    required super.backdropPath,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'] != null && json['backdrop_path'] != ''
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://ih1.redbubble.net/image.533910704.5853/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg',
      budget: json['budget'],
        genres: json['genres'] != null
          ? (json['genres'] as List).map<Genre>((x) => Genre.fromJson(x)).toList()
          : [],
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'] != null && json['poster_path'] != ''
          ? 'https://image.tmdb.org/t/p/w200${json['poster_path']}'
          : 'https://ih1.redbubble.net/image.533910704.5853/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg',
      releaseDate: DateTime.parse(json['release_date']),
      revenue: json['revenue'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
     popularity: json['popularity']
    );
  }
}
