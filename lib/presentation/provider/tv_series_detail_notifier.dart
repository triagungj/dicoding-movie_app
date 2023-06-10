import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  TvSeriesDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchlistStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistStatusTv getWatchlistStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;
  RequestState _tvSeriesDetailState = RequestState.empty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;

  late List<TvSeries> _tvSeriesRecommendations;
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;
  RequestState _tvSeriesRecommendationsState = RequestState.empty;
  RequestState get tvSeriesRecommendationsState =>
      _tvSeriesRecommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesDetailState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvSeriesDetailState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesRecommendationsState = RequestState.loading;
        _tvSeriesDetail = tvSeries;
        notifyListeners();

        recommendationResult.fold((failure) {
          _tvSeriesRecommendationsState = RequestState.error;
          _message = failure.message;
        }, (recommendations) {
          _tvSeriesRecommendationsState = RequestState.loaded;
          _tvSeriesRecommendations = recommendations;
        });

        _tvSeriesDetailState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await saveWatchlistTv.execute(tvSeriesDetail);

    await result.fold(
      (l) async {
        _watchlistMessage = l.message;
      },
      (r) async {
        _watchlistMessage = r;
      },
    );
    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> removeWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await removeWatchlistTv.execute(tvSeriesDetail);

    await result.fold(
      (l) async {
        _watchlistMessage = l.message;
      },
      (r) async {
        _watchlistMessage = r;
      },
    );
    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatusTv.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
