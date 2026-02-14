import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetPopularMoviesUseCase getPopularMovies;

  MoviesCubit(this.getPopularMovies) : super(MoviesInitial());

  int _page = 1;
  bool _isLoading = false;
  final List<MovieEntity> _movies = [];

  Future<void> loadInitialMovies() async {
    emit(MoviesLoading());

    try {
      _page = 1;
      _movies.clear();
      final movies = await getPopularMovies(_page);
      _movies.addAll(movies);
      emit(MoviesLoaded(List.from(_movies)));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> loadMoreMovies() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      _page++;
      final movies = await getPopularMovies(_page);
      _movies.addAll(movies);
      emit(MoviesLoaded(List.from(_movies)));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
    _isLoading = false;
  }
}
