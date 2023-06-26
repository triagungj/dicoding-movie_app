import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/remove_watchlist_movie.dart';

part 'movie_watchlist_remove_event.dart';
part 'movie_watchlist_remove_state.dart';

class MovieWatchlistRemoveBloc
    extends Bloc<MovieWatchlistRemoveEvent, MovieWatchlistRemoveState> {
  MovieWatchlistRemoveBloc({
    required this.removeWatchlistMovie,
  }) : super(MovieWatchlistRemoveInitial()) {
    on<AddMovieWatchlistRemoveEvent>((event, emit) async {
      emit(MovieWatchlistRemoveLoading());

      final call = await removeWatchlistMovie.execute(event.movieDetail);

      call.fold(
        (l) => emit(MovieWatchlistRemoveFailure(l.message)),
        (r) => emit(MovieWatchlistRemoveSuccess(r)),
      );
    });
  }

  final RemoveWatchlistMovie removeWatchlistMovie;
}
