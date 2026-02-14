import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';


class MovieDetailModel extends MovieDetailsEntity {
  MovieDetailModel({
    required super.adult,
    required super.backdropPath,
    required super.belongsToCollection,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.productionCompanies,
    required super.productionCountries,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.spokenLanguages,
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
        belongsToCollection: BelongsToCollection.fromJson(json['belongs_to_collection']),
        budget: json['budget'],
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        originCountry: List<String>.from(json['origin_country'].map((x) => x)),
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'] != null && json['poster_path'] != ''
          ? 'https://image.tmdb.org/t/p/w200${json['poster_path']}'
          : 'https://ih1.redbubble.net/image.533910704.5853/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg',
        productionCompanies: List<ProductionCompany>.from(json['production_companies'].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(json['production_countries'].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json['release_date']),
        revenue: json['revenue'],
        runtime: json['runtime'],
        spokenLanguages: List<SpokenLanguage>.from(json['spoken_languages'].map((x) => SpokenLanguage.fromJson(x))),
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
    );
  }
}
