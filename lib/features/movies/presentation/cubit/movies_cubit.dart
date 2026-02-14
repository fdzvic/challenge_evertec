import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetPopularMoviesUseCase getPopularMovies;
  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetTopRatedMoviesUseCase getTopRatedMovies;
  final GetUpcomingMoviesUseCase getUpcomingMovies;

  MoviesCubit({
    required this.getPopularMovies,
    required this.getNowPlayingMovies,
    required this.getTopRatedMovies,
    required this.getUpcomingMovies,
  }) : super(MoviesInitial());

  int _popularPage = 1;
  int _nowPlayingPage = 1;
  int _topRatedPage = 1;
  int _upcomingPage = 1;
  bool _loadingPopular = false;
  bool _loadingNowPlaying = false;
  bool _loadingTopRated = false;
  bool _loadingUpcoming = false;
  final List<MovieEntity> _nowPlayingMovies = [];
  final List<MovieEntity> _popularMovies = [];
  final List<MovieEntity> _topRatedMovies = [];
   final List<MovieEntity> _upcomingMovies = [];

  Future<void> loadInitialMovies() async {
    if (state is MoviesLoaded) return;
    emit(MoviesLoading());
    
    try {
      final popularMovies = await getPopularMovies(1);
      final nowPlayingMovies = await getNowPlayingMovies(1);
      final topRatedMovies = await getTopRatedMovies(1);
      final upcomingMovies = await getUpcomingMovies(1);
      _popularMovies.addAll(popularMovies);
      _nowPlayingMovies.addAll(nowPlayingMovies);
      _topRatedMovies.addAll(topRatedMovies);
      _upcomingMovies.addAll(upcomingMovies);
      emit(
        MoviesLoaded(
          nowPlayingMovies: List.from(_nowPlayingMovies),
          popularMovies: List.from(_popularMovies),
          topRatedMovies: List.from(_topRatedMovies),
          upcomingMovies: List.from(_upcomingMovies),
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
          upcomingMovies: List.unmodifiable(_upcomingMovies),
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

  Future<void> loadMoreMoviesUpcoming() => _loadMore(
    fetch: getUpcomingMovies.call,
    targetList: _upcomingMovies,
    getPage: () => _upcomingPage,
    setPage: (p) => _upcomingPage = p,
    isLoading: () => _loadingUpcoming,
    setLoading: (v) => _loadingUpcoming = v,
  );
}
