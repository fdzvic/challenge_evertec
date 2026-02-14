import 'package:challenge_evertec/features/movies/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieByIdUsecase getMovieById;

  MovieDetailCubit(this.getMovieById) : super(MovieDetailInitial());

  Future<void> loadMovieDetails(String id) async {
    if (state is MovieDetailLoaded) return;
    emit(MovieDetailLoading());
    try {
      final movie = await getMovieById(id);
      emit(MovieDetailLoaded(movie));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
