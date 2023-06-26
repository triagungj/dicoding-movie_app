import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());

      final call = await getMovieDetail.execute(event.id);

      call.fold(
        (l) => emit(MovieDetailFailure(l.message)),
        (r) => emit(MovieDetailSuccess(r)),
      );
    });
  }

  final GetMovieDetail getMovieDetail;
}
