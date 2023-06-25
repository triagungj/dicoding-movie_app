import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';

part 'movies_popular_event.dart';
part 'movies_popular_state.dart';

class MoviesPopularBloc extends Bloc<MoviesPopularEvent, MoviesPopularState> {
  MoviesPopularBloc({
    required this.getPopularMovies,
  }) : super(MoviesPopularInitial()) {
    on<GetMoviesPopularEvent>((event, emit) async {
      emit(MoviesPopularLoading());

      final call = await getPopularMovies.execute();

      call.fold(
        (l) => emit(MoviesPopularFailure(l.message)),
        (r) => emit(MoviesPopularSuccess(r)),
      );
    });
  }

  final GetPopularMovies getPopularMovies;
}
