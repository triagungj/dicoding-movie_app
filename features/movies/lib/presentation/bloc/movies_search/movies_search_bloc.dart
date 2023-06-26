import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';

part 'movies_search_event.dart';
part 'movies_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  MoviesSearchBloc({
    required this.searchMovies,
  }) : super(MoviesSearchInitial()) {
    on<GetMoviesSearchEvent>((event, emit) async {
      emit(MoviesSearchLoading());

      final call = await searchMovies.execute(event.query);

      call.fold(
        (l) => emit(MoviesSearchFailure(l.message)),
        (r) => emit(MoviesSearchSuccess(r)),
      );
    });
  }

  final SearchMovies searchMovies;
}
