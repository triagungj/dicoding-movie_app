import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_search.dart';
import 'package:flutter/foundation.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  TvSeriesSearchNotifier(this.getTvSearch);

  final GetTvSearch getTvSearch;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _listSearchTv = [];
  List<TvSeries> get listTvSeries => _listSearchTv;

  Future<void> fetchSearchedTv(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvSearch.execute(query);

    result.fold(
      (l) {
        _message = l.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (r) {
        _listSearchTv = r;
        _message = 'Success get data';
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
