import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  WatchlistTvSeriesNotifier(this.getWatchlistTv);

  final GetWatchlistTv getWatchlistTv;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _listWatchlist = [];
  List<TvSeries> get listWatchlistTv => _listWatchlist;

  Future<void> fetchWatchlistTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();

    result.fold(
      (l) {
        _message = l.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (r) {
        _listWatchlist = r;
        _state = RequestState.loaded;
        _message = 'Success get data';
        notifyListeners();
      },
    );
  }
}
