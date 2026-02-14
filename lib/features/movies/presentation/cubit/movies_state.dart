import '../../domain/entities/movie_entity.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;

  MoviesLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
