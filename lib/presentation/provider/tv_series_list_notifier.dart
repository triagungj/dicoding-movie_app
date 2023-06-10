import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  TvSeriesListNotifier(
    this.getTvAiringToday,
    this.getTvPopular,
    this.getTvTopRated,
  );

  final GetTvAiringToday getTvAiringToday;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;

  RequestState _airingTodayTvState = RequestState.empty;
  RequestState get airingTodayTvState => _airingTodayTvState;
  var _airingTodayTv = <TvSeries>[];
  List<TvSeries> get airingTodayTv => _airingTodayTv;

  RequestState _popularTvState = RequestState.empty;
  RequestState get popularTvState => _popularTvState;
  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => _popularTv;

  RequestState _topRatedTvState = RequestState.empty;
  RequestState get topRatedTvState => _topRatedTvState;
  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => _topRatedTv;

  String _message = '';
  String get message => _message;

  Future<void> getAiringTodayTv() async {
    _airingTodayTvState = RequestState.loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();

    result.fold(
      (l) {
        _airingTodayTvState = RequestState.error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _airingTodayTvState = RequestState.loaded;
        _airingTodayTv = r;
        notifyListeners();
      },
    );
  }

  Future<void> getPopularTv() async {
    _popularTvState = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();

    result.fold(
      (l) {
        _popularTvState = RequestState.error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _popularTvState = RequestState.loaded;
        _popularTv = r;
        notifyListeners();
      },
    );
  }

  Future<void> getTopRatedTv() async {
    _topRatedTvState = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold(
      (l) {
        _topRatedTvState = RequestState.error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _topRatedTvState = RequestState.loaded;
        _topRatedTv = r;
        notifyListeners();
      },
    );
  }
}
