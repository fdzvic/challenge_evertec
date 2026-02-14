import '../../domain/entities/movie_entity.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> upcomingMovies;

  MoviesLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
