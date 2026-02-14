import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  MovieDetailLoaded(this.movie);
  final MovieDetailsEntity movie;
}

class MovieDetailError extends MovieDetailState {
  MovieDetailError(this.message);
  final String message;
}
