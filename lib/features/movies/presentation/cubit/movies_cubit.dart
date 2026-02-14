import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetPopularMoviesUseCase getPopularMovies;
  final GetNowPlayingMoviesUseCase getNowPlayingMovies;

  MoviesCubit(this.getPopularMovies, this.getNowPlayingMovies)
    : super(MoviesInitial());

  int _popularPage = 1;
  int _nowPlayingPage = 1;
  bool _isLoading = false;
  bool _loadingPopular = false;
  bool _loadingNowPlaying = false;
  final List<MovieEntity> _nowPlayingMovies = [];
  final List<MovieEntity> _popularMovies = [];

  Future<void> loadInitialMovies() async {
    emit(MoviesLoading());

    try {
      _popularMovies.clear();
      _nowPlayingMovies.clear();
      final popularMovies = await getPopularMovies(1);
      final nowPlayingMovies = await getNowPlayingMovies(1);
      _popularMovies.addAll(popularMovies);
      _nowPlayingMovies.addAll(nowPlayingMovies);
      emit(
        MoviesLoaded(List.from(_nowPlayingMovies), List.from(_popularMovies)),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> _loadMore({
    required Future<List<MovieEntity>> Function(int page) fetch,
    required List<MovieEntity> targetList,
    required int Function() getPage,
    required void Function(int) setPage,
    required bool Function() isLoading,
    required void Function(bool) setLoading,
  }) async {
    if (isLoading()) return;
    setLoading(true);

    try {
      final nextPage = getPage() + 1;
      final movies = await fetch(nextPage);

      setPage(nextPage);
      targetList.addAll(movies);

      emit(
        MoviesLoaded(
          List.unmodifiable(_nowPlayingMovies),
          List.unmodifiable(_popularMovies),
        ),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      setLoading(false);
    }
  }

  Future<void> loadMoreMoviesPopular() => _loadMore(
    fetch: getPopularMovies.call,
    targetList: _popularMovies,
    getPage: () => _popularPage,
    setPage: (p) => _popularPage = p,
    isLoading: () => _loadingPopular,
    setLoading: (v) => _loadingPopular = v,
  );

  Future<void> loadMoreMoviesNowPlaying() => _loadMore(
    fetch: getNowPlayingMovies.call,
    targetList: _nowPlayingMovies,
    getPage: () => _nowPlayingPage,
    setPage: (p) => _nowPlayingPage = p,
    isLoading: () => _loadingNowPlaying,
    setLoading: (v) => _loadingNowPlaying = v,
  );
}
