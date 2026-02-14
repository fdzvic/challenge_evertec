import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}
class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailsEntity movie;

  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}
