import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movie.dart';

part 'movie_watchlist_status_event.dart';

class MovieWatchlistStatusBloc extends Bloc<MovieWatchlistStatusEvent, bool> {
  MovieWatchlistStatusBloc({
    required this.getWatchListStatusMovie,
  }) : super(false) {
    on<GetMovieWatchlistStatusEvent>(
      (event, emit) async {
        final result = await getWatchListStatusMovie.execute(event.id);

        emit(result);
      },
    );
  }

  final GetWatchListStatusMovie getWatchListStatusMovie;
}
