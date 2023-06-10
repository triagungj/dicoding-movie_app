import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/foundation.dart';

class TvSeriesTopRatedNotifier extends ChangeNotifier {
  TvSeriesTopRatedNotifier(this.getTvTopRated);

  final GetTvTopRated getTvTopRated;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _listTopRated = [];
  List<TvSeries> get listTopRated => _listTopRated;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold(
      (l) {
        _state = RequestState.error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _state = RequestState.loaded;
        _listTopRated = r;
        _message = 'Success get data';
        notifyListeners();
      },
    );
  }
}
