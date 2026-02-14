import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetPopularMoviesUseCase getPopularMovies;
  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetTopRatedMoviesUseCase getTopRatedMovies;

  MoviesCubit({
    required this.getPopularMovies,
    required this.getNowPlayingMovies,
    required this.getTopRatedMovies,
  }) : super(MoviesInitial());

  int _popularPage = 1;
  int _nowPlayingPage = 1;
  int _topRatedPage = 1;
  bool _loadingPopular = false;
  bool _loadingNowPlaying = false;
  bool _loadingTopRated = false;
  final List<MovieEntity> _nowPlayingMovies = [];
  final List<MovieEntity> _popularMovies = [];
  final List<MovieEntity> _topRatedMovies = [];

  Future<void> loadInitialMovies() async {
    emit(MoviesLoading());

    try {
      _popularMovies.clear();
      _nowPlayingMovies.clear();
      _topRatedMovies.clear();
      final popularMovies = await getPopularMovies(1);
      final nowPlayingMovies = await getNowPlayingMovies(1);
      final topRatedMovies = await getTopRatedMovies(1);
      _popularMovies.addAll(popularMovies);
      _nowPlayingMovies.addAll(nowPlayingMovies);
      _topRatedMovies.addAll(topRatedMovies);
      emit(
        MoviesLoaded(
          nowPlayingMovies: List.from(_nowPlayingMovies),
          popularMovies: List.from(_popularMovies),
          topRatedMovies: List.from(_topRatedMovies),
        ),
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
          nowPlayingMovies: List.unmodifiable(_nowPlayingMovies),
          topRatedMovies: List.unmodifiable(_topRatedMovies),
          popularMovies: List.unmodifiable(_popularMovies),
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

  Future<void> loadMoreMoviesTopRated() => _loadMore(
    fetch: getTopRatedMovies.call,
    targetList: _topRatedMovies,
    getPage: () => _topRatedPage,
    setPage: (p) => _topRatedPage = p,
    isLoading: () => _loadingTopRated,
    setLoading: (v) => _loadingTopRated = v,
  );
}
