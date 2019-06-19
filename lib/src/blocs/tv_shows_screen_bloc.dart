import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/resources/repository.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:rxdart/rxdart.dart';

class TvShowsScreenBloc {
  final _repository = Repository();

  final _tvShowsImageProvider = PublishSubject<String>();
  final _tvShowsPageScaleProvider = BehaviorSubject<double>();
  final _tvShowsPagePositionProvider = PublishSubject<double>();

  final _tvShowsProvider = PublishSubject<List<TvShowModel>>();

  Observable<String> get getTvShowsBackgroundImage => _tvShowsImageProvider.stream;
  Observable<double> get getTvShowsPageScale => _tvShowsPageScaleProvider.stream;
  Observable<double> get getTvShowsPagePosition => _tvShowsPagePositionProvider.stream;

  Observable<List<TvShowModel>> get getAllTvShows => _tvShowsProvider.stream;

  Function(double) get pushTvShowsScale => _tvShowsPageScaleProvider.sink.add;
  Function(double) get pushTvShowsPagePosition=> _tvShowsPagePositionProvider.sink.add;
  Function(String) get setTvShowsBackgroundImage => _tvShowsImageProvider.sink.add;


  double _tvShowsCurrentPageNum = 0;

  MovieType movieType;
  List<TvShowModel> tvShows;
  int _tvShowsTotalPageNum;
  int _tvShowsRequestedPageNum;

//  void fetchAllComingSoonMoviesByPage(int page) async{
//    if( page == 1 ){
//      await _repository.getUpcomingMoviesByPage(page).then( (model) {
//        _moviesTotalPageNum = model.totalPages;
//        if(model.movies != null){
//          movies.addAll(model.movies);
//          _tvShowsProvider.sink.add(movies);
//        }
//      });
//    }else if (page <= _moviesTotalPageNum && _moviesRequestedPageNum + 1 == page ) {
//      _moviesRequestedPageNum += 1;
//      await _repository.getUpcomingMoviesByPage(page).then( (model) {
//        if(model.movies != null){
//          movies.addAll(model.movies);
//          _tvShowsProvider.sink.add(movies);
//        }
//      });
//    }
//  }

  void fetchAllPopularTvShowsByPage(int page) async{
    if( page == 1 ){
      await _repository.getMostPopularTvShowsByPage(page).then( (model) {
        _tvShowsTotalPageNum = model.totalPages;
        if(model.tvShows != null){
          tvShows.addAll(model.tvShows);
          _tvShowsProvider.sink.add(tvShows);
        }
      });
    }else if (page <= _tvShowsTotalPageNum && _tvShowsRequestedPageNum + 1 == page ) {
      _tvShowsRequestedPageNum += 1;
      await _repository.getMostPopularTvShowsByPage(page).then( (model) {
        if(model.tvShows != null){
          tvShows.addAll(model.tvShows);
          _tvShowsProvider.sink.add(tvShows);
        }
      });
    }
  }

  void fetchAllTopRatedTvShowsByPage(int page) async{
    if( page == 1 ){
      await _repository.getTopRatedTvShowsByPage(page).then( (model) {
        _tvShowsTotalPageNum = model.totalPages;
        if(model.tvShows != null){
          tvShows.addAll(model.tvShows);
          _tvShowsProvider.sink.add(tvShows);
        }
      });
    }else if (page <= _tvShowsTotalPageNum && _tvShowsRequestedPageNum + 1 == page ) {
      _tvShowsRequestedPageNum += 1;
      await _repository.getTopRatedTvShowsByPage(page).then( (model) {
        if(model.tvShows != null){
          tvShows.addAll(model.tvShows);
          _tvShowsProvider.sink.add(tvShows);
        }
      });
    }
  }

  initSeeAll(TvShowType tvShowType){
    tvShows = [];
    _tvShowsTotalPageNum = 0;
    _tvShowsRequestedPageNum = 1;

    if(tvShowType == TvShowType.Popular){
      fetchAllPopularTvShowsByPage(1);
    }else if(tvShowType == TvShowType.TopRated){
      fetchAllTopRatedTvShowsByPage(1);
    }
  }

  double getCurrentTvShowsPage () => _tvShowsCurrentPageNum;


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
