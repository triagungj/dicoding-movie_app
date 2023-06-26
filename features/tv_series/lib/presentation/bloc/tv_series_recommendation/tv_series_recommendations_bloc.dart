import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';

part 'tv_series_recommendations_event.dart';
part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsBloc
    extends Bloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState> {
  TvSeriesRecommendationsBloc({
    required this.getTvRecommendations,
  }) : super(TvSeriesRecommendationsInitial()) {
    on<GetTvSeriesRecommendationsEvent>((event, emit) async {
      emit(TvSeriesRecommendationsLoading());

      final call = await getTvRecommendations.execute(event.id);

      call.fold(
        (l) => emit(TvSeriesRecommendationsFailure(l.message)),
        (r) => emit(TvSeriesRecommendationsSuccess(r)),
      );
    });
  }

  final GetTvRecommendations getTvRecommendations;
}
