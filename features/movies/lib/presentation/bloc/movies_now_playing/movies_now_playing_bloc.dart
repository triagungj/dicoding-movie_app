import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'movies_now_playing_event.dart';
part 'movies_now_playing_state.dart';

class MoviesNowPlayingBloc
    extends Bloc<MoviesNowPlayingEvent, MoviesNowPlayingState> {
  MoviesNowPlayingBloc({
    required this.getNowPlayingMovies,
  }) : super(MoviesNowPlayingInitial()) {
    on<MoviesNowPlayingEvent>(
      (event, emit) async {
        emit(MoviesNowPlayingLoading());

        final result = await getNowPlayingMovies.execute();

        result.fold(
          (l) => emit(MoviesNowPlayingFailure(l.message)),
          (r) => emit(MoviesNowPlayingSuccess(r)),
        );
      },
    );
  }
  final GetNowPlayingMovies getNowPlayingMovies;
}
