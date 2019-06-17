import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/resources/repository.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:rxdart/rxdart.dart';

class TvShowsScreenBloc {
  final _repository = Repository();

  final _tvShowsImageProvider = PublishSubject<String>();
  final _tvShowsPageScaleProvider = BehaviorSubject<double>();
  final _tvShowsPagePositionProvider = PublishSubject<double>();

  final _tvShowsProvider = PublishSubject<List<MovieModel>>();

  Observable<String> get getTvShowsBackgroundImage => _tvShowsImageProvider.stream;
  Observable<double> get getTvShowsPageScale => _tvShowsPageScaleProvider.stream;
  Observable<double> get getTvShowsPagePosition => _tvShowsPagePositionProvider.stream;

  Observable<List<MovieModel>> get getAllMovies => _tvShowsProvider.stream;

  Function(double) get pushTvShowsScale => _tvShowsPageScaleProvider.sink.add;
  Function(double) get pushTvShowsPagePosition=> _tvShowsPagePositionProvider.sink.add;
  Function(String) get setTvShowsBackgroundImage => _tvShowsImageProvider.sink.add;


  double _tvShowsCurrentPageNum = 0;

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
          _tvShowsProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum && _moviesRequestedPageNum + 1 == page ) {
      _moviesRequestedPageNum += 1;
      await _repository.getUpcomingMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _tvShowsProvider.sink.add(movies);
        }
      });
    }
  }

  void fetchAllPopularTvShowsByPage(int page) async{
    if( page == 1 ){
      await _repository.getMostPopularMoviesByPage(page).then( (model) {
        _moviesTotalPageNum = model.totalPages;
        if(model.movies != null){
          movies.addAll(model.movies);
          _tvShowsProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum && _moviesRequestedPageNum + 1 == page ) {
      _moviesRequestedPageNum += 1;
      await _repository.getMostPopularMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _tvShowsProvider.sink.add(movies);
        }
      });
    }
  }

  void fetchAllTopRatedTvShowsByPage(int page) async{
    if( page == 1 ){
      await _repository.getTopRatedMoviesByPage(page).then( (model) {
        _moviesTotalPageNum = model.totalPages;
        if(model.movies != null){
          movies.addAll(model.movies);
          _tvShowsProvider.sink.add(movies);
        }
      });
    }else if (page <= _moviesTotalPageNum ) {
      _moviesRequestedPageNum += 1;
      await _repository.getTopRatedMoviesByPage(page).then( (model) {
        if(model.movies != null){
          movies.addAll(model.movies);
          _tvShowsProvider.sink.add(movies);
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
      fetchAllTopRatedTvShowsByPage(1);
    }else{
      fetchAllPopularTvShowsByPage(1);
    }
  }

  double getCurrentMoviesPage () => _tvShowsCurrentPageNum;


  TvShowsScreenBloc(){
    _tvShowsPagePositionProvider.listen( (value) {
      _tvShowsCurrentPageNum = value;
    });
  }

  dispose(){
    _tvShowsImageProvider.close();
    _tvShowsPageScaleProvider.close();
    _tvShowsPagePositionProvider.close();

    _tvShowsProvider.close();
  }
}
