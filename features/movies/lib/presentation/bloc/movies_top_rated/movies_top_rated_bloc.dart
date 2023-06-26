import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'movies_top_rated_event.dart';
part 'movies_top_rated_state.dart';

class MoviesTopRatedBloc
    extends Bloc<MoviesTopRatedEvent, MoviesTopRatedState> {
  MoviesTopRatedBloc({
    required this.getTopRatedMovies,
  }) : super(MoviesTopRatedInitial()) {
    on<GetMoviesTopRatedEvent>((event, emit) async {
      emit(MoviesTopRatedLoading());

      final call = await getTopRatedMovies.execute();

      call.fold(
        (l) => emit(MoviesTopRatedFailure(l.message)),
        (r) => emit(MoviesTopRatedSuccess(r)),
      );
    });
  }
  final GetTopRatedMovies getTopRatedMovies;
}
