import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter/foundation.dart';

class TvSeriesAiringTodayNotifier extends ChangeNotifier {
  TvSeriesAiringTodayNotifier(this.getTvAiringToday);

  final GetTvAiringToday getTvAiringToday;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _listAiringTodayTv = [];
  List<TvSeries> get listAiringTodayTv => _listAiringTodayTv;

  Future<void> fetchAiringTodayTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();

    result.fold(
      (l) {
        _state = RequestState.error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _state = RequestState.loaded;
        _listAiringTodayTv = r;
        notifyListeners();
      },
    );
  }
}
