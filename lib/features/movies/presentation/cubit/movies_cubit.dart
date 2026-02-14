import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetPopularMoviesUseCase getPopularMovies;

  MoviesCubit(this.getPopularMovies) : super(MoviesInitial());

  Future<void> loadMovies() async {
    emit(MoviesLoading());

    try {
      final movies = await getPopularMovies();
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError('Failed to fetch popular movies'));
    }
  }
}
