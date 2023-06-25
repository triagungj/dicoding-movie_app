import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';

part 'movie_watchlist_load_event.dart';
part 'movie_watchlist_load_state.dart';

class MovieWatchlistLoadBloc
    extends Bloc<MovieWatchlistLoadEvent, MovieWatchlistLoadState> {
  MovieWatchlistLoadBloc({
    required this.getWatchlistMovies,
  }) : super(MovieWatchlistLoadInitial()) {
    on<GetMovieWatchlistLoadEvent>((event, emit) async {
      emit(MovieWatchlistLoadLoading());

      final call = await getWatchlistMovies.execute();

      call.fold(
        (l) => emit(MovieWatchlistLoadFailure(l.message)),
        (r) => emit(MovieWatchlistLoadSuccess(r)),
      );
    });
  }

  final GetWatchlistMovies getWatchlistMovies;
}
