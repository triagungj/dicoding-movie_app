import 'package:dependencies/http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/data/datasources/db/tv_series_db_helper.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

@GenerateMocks(
  [
    TvSeriesRepository,
    TvSeriesRemoteDataSource,
    TvSeriesLocalDataSource,
    TvSeriesDbHelper,
  ],
  customMocks: [MockSpec<IOClient>(as: #MockIOClient)],
)
void main() {}
