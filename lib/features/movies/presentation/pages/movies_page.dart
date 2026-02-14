import 'package:challenge_evertec/features/movies/presentation/widgets/movies_horizontal_listview.dart';
import 'package:challenge_evertec/features/movies/presentation/widgets/movies_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/design/molecules/molecules.dart';
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesCubit>()..loadInitialMovies(),
      child: const MoviesView(),
    );
  }
}

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<MoviesCubit>().loadMoreMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          return switch (state) {
            MoviesLoading() => const Center(child: CircularProgressIndicator()),
            MoviesLoaded(:final movies) => Column(
              children: [
                EvAppBar(),
                MoviesSlider(movies: movies.sublist(0, 6)),
                MoviesHorizontalListview(
                  movies: movies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage: () => context.read<MoviesCubit>().loadMoreMovies(),
                )
              ],
            ),
            MoviesError(:final message) => Center(child: Text(message)),
            _ => const SizedBox(),
          };
        },
      );
  }
}
