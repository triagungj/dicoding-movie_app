import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'movies_recommendation_event.dart';
part 'movies_recommendation_state.dart';

class MoviesRecommendationBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  MoviesRecommendationBloc({
    required this.getMovieRecommendations,
  }) : super(MoviesRecommendationInitial()) {
    on<GetMoviesRecommendationEvent>((event, emit) async {
      emit(MoviesRecommendationLoading());

      final call = await getMovieRecommendations.execute(event.id);

      call.fold(
        (l) => emit(MoviesRecommendationFailure(l.message)),
        (r) => emit(MoviesRecommendationSuccess(r)),
      );
    });
  }
  final GetMovieRecommendations getMovieRecommendations;
}
