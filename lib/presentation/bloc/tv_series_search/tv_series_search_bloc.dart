import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_search.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  TvSeriesSearchBloc({
    required this.getTvSearch,
  }) : super(TvSeriesSearchInitial()) {
    on<GetTvSeriesSearchEvent>((event, emit) async {
      emit(TvSeriesSearchLoading());

      final call = await getTvSearch.execute(event.query);

      call.fold(
        (l) => emit(TvSeriesSearchFailure(l.message)),
        (r) => emit(TvSeriesSearchSuccess(r)),
      );
    });
  }

  final GetTvSearch getTvSearch;
}
