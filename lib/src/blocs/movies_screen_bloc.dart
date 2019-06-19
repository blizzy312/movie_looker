import 'package:movie_looker/src/models/genre_model.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/resources/repository.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:rxdart/rxdart.dart';

class MoviesScreenBloc {
  final _repository = Repository();

  final _moviesImageProvider = PublishSubject<String>();
  final _moviesPageScaleProvider = BehaviorSubject<double>();
  final _moviesPagePositionProvider = PublishSubject<double>();

  final _moviesProvider = BehaviorSubject<List<MovieModel>>();

  final _moviesGenresProvider = PublishSubject<List<GenreModel>>();
  final _moviesGenresIdsProvider = PublishSubject<List<int>>();


  Observable<String> get getMoviesBackgroundImage => _moviesImageProvider.stream;
  Observable<double> get getMoviesPageScale => _moviesPageScaleProvider.stream;
  Observable<double> get getMoviesPagePosition => _moviesPagePositionProvider.stream;

  Observable<List<MovieModel>> get getAllMovies => _moviesProvider.stream;

  Observable<List<GenreModel>> get getGenreNames => _moviesGenresProvider.stream;

  Function(double) get pushMoviesScale => _moviesPageScaleProvider.sink.add;
  Function(double) get pushMoviesPagePosition=> _moviesPagePositionProvider.sink.add;
  Function(String) get setMoviesBackgroundImage => _moviesImageProvider.sink.add;

  Function(List<int>) get pushGenreIds => _moviesGenresIdsProvider.sink.add;

  double _moviesCurrentPageNum = 0;

  MovieType movieType;
  List<MovieModel> movies;
  int _moviesTotalPageNum;
  int _moviesRequestedPageNum;

  void fetchAllComingSoonMoviesByPage(int page) async{
    if( page == 1 ){
      await _repository.getUpcomingMoviesByPage(page).then( (model) {
        _moviesTotalPageNum = model.totalPages;
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum && _moviesRequestedPageNum + 1 == page ) {
      _moviesRequestedPageNum += 1;
      await _repository.getUpcomingMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }
  }

  void fetchAllPopularMoviesByPage(int page) async{
    if( page == 1 ){
      await _repository.getMostPopularMoviesByPage(page).then( (model) {
        _moviesTotalPageNum = model.totalPages;
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum && _moviesRequestedPageNum + 1 == page ) {
      _moviesRequestedPageNum += 1;
      await _repository.getMostPopularMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }
  }

  void fetchAllTopRatedMoviesByPage(int page) async{
    if( page == 1 ){
      await _repository.getTopRatedMoviesByPage(page).then( (model) {
        _moviesTotalPageNum = model.totalPages;
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum ) {
      _moviesRequestedPageNum += 1;
      await _repository.getTopRatedMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _moviesProvider.sink.add(movies);
        }
      });
    }
  }

  initSeeAll(MovieType movieType){
    movies = [];
    _moviesTotalPageNum = 0;
    _moviesRequestedPageNum = 1;
    if(movieType == MovieType.ComingSoon){
      fetchAllComingSoonMoviesByPage(1);
    }else if(movieType == MovieType.TopRated){
      fetchAllTopRatedMoviesByPage(1);
    }else{
      fetchAllPopularMoviesByPage(1);
    }
  }

  double getCurrentMoviesPage () => _moviesCurrentPageNum;


  MoviesScreenBloc(){
    _moviesPagePositionProvider.listen( (value) {
      _moviesCurrentPageNum = value;
    });

    _moviesGenresIdsProvider.listen( (values) async {
      await _repository.getMovieGenres().then( (genres) {
        List<GenreModel> newGenres = [];
        for(var value in values){
          genres.forEach( (model) {
            if(value == model.id){
              newGenres.add(model);
            }
          });
        }
        _moviesGenresProvider.sink.add(newGenres);
      });
    });
  }

  dispose(){
    _moviesImageProvider.close();
    _moviesPageScaleProvider.close();
    _moviesPagePositionProvider.close();

    _moviesProvider.close();

    _moviesGenresProvider.close();
    _moviesGenresIdsProvider.close();
  }
}
