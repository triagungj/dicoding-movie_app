import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';

part 'movie_watchlist_insert_event.dart';
part 'movie_watchlist_insert_state.dart';

class MovieWatchlistInsertBloc
    extends Bloc<MovieWatchlistInsertEvent, MovieWatchlistInsertState> {
  MovieWatchlistInsertBloc({
    required this.saveWatchlistMovie,
  }) : super(MovieWatchlistInsertInitial()) {
    on<AddMovieWatchlistInsertEvent>((event, emit) async {
      emit(MovieWatchlistInsertLoading());

      final call = await saveWatchlistMovie.execute(event.movieDetail);

      call.fold(
        (l) => emit(MovieWatchlistInsertFailure(l.message)),
        (r) => emit(MovieWatchlistInsertSuccess(r)),
      );
    });
  }

  final SaveWatchlistMovie saveWatchlistMovie;
}
