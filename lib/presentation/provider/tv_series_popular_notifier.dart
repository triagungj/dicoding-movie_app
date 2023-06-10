import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:flutter/foundation.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  TvSeriesPopularNotifier({
    required this.getTvPopular,
  });

  final GetTvPopular getTvPopular;

  RequestState _tvSeriesPopularState = RequestState.empty;
  RequestState get tvSeriesPopularState => _tvSeriesPopularState;
  List<TvSeries> _listTvSeriesPopular = [];
  List<TvSeries> get listTvSeriesPopular => _listTvSeriesPopular;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _tvSeriesPopularState = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();

    result.fold(
      (failure) {
        _tvSeriesPopularState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (listPopular) {
        _listTvSeriesPopular = listPopular;
        _tvSeriesPopularState = RequestState.loaded;
        _message = 'Success';
        notifyListeners();
      },
    );
  }
}
