import 'package:dependencies/http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/data/datasources/db/movies_db_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    MoviesDbHelper,
  ],
  customMocks: [MockSpec<IOClient>(as: #MockIOClient)],
)
void main() {}
