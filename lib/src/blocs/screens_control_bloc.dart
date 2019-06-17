
import 'package:movie_looker/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ScreensControlBloc {
  final _repository = Repository();

  double _moviesCurrentPageNum = 0;
  double _tvShowsCurrentPageNum = 0;
  double _celebsCurrentPageNum = 0;

  final _moviesImageProvider = PublishSubject<String>();
  final _moviesPageScaleProvider = BehaviorSubject<double>();
  final _moviesPagePositionProvider = PublishSubject<double>();

  Observable<String> get getMoviesBackgroundImage => _moviesImageProvider.stream;
  Observable<double> get getMoviesPageScale => _moviesPageScaleProvider.stream;
  Observable<double> get getMoviesPagePosition => _moviesPagePositionProvider.stream;


  Function(double) get pushMoviesScale => _moviesPageScaleProvider.sink.add;
  Function(double) get pushMoviesPagePosition=> _moviesPagePositionProvider.sink.add;
  Function(String) get setMoviesBackgroundImage => _moviesImageProvider.sink.add;

  final _tvShowsImageProvider = PublishSubject<String>();
  final _tvShowsPageScaleProvider = BehaviorSubject<double>();
  final _tvShowsPagePositionProvider = PublishSubject<double>();

  Observable<String> get getTvShowsBackgroundImage => _tvShowsImageProvider.stream;
  Observable<double> get getTvShowsPageScale => _tvShowsPageScaleProvider.stream;
  Observable<double> get getTvShowsPagePosition => _tvShowsPagePositionProvider.stream;


  Function(double) get pushTvShowsScale => _tvShowsPageScaleProvider.sink.add;
  Function(double) get pushTvShowsPagePosition=> _tvShowsPagePositionProvider.sink.add;
  Function(String) get setTvShowsBackgroundImage => _tvShowsImageProvider.sink.add;


  final _celebsImageProvider = PublishSubject<String>();
  final _celebsPageScaleProvider = BehaviorSubject<double>();
  final _celebsPagePositionProvider = PublishSubject<double>();

  Observable<String> get getCelebsBackgroundImage => _celebsImageProvider.stream;
  Observable<double> get getCelebsPageScale => _celebsPageScaleProvider.stream;
  Observable<double> get getCelebsPagePosition => _celebsPagePositionProvider.stream;


  Function(double) get pushCelebsScale => _celebsPageScaleProvider.sink.add;
  Function(double) get pushCelebsPagePosition=> _celebsPagePositionProvider.sink.add;
  Function(String) get setCelebsBackgroundImage => _celebsImageProvider.sink.add;


  double getCurrentMoviesPage () => _moviesCurrentPageNum;
  double getCurrentTvShowsPage () => _tvShowsCurrentPageNum;
  double getCurrentCelebsPage () => _celebsCurrentPageNum;

  ScreensControlBloc(){
    _moviesPagePositionProvider.listen( (value) {
      _moviesCurrentPageNum = value;
    });
    _tvShowsPagePositionProvider.listen( (value) {
      _tvShowsCurrentPageNum = value;
    });
    _celebsPagePositionProvider.listen( (value) {
      _celebsCurrentPageNum = value;
    });
  }
//
//  final _cache = Map<int, MovieModel>();
//  final _downloaders = Map<int, Future<DiscoverMoviesModel>>();
//
//  /// Downloads the podcast, if necessary.
//  Future<MovieModel> getPodcast(int index) async {
//    print('get podcast $index');
//    if (!_cache.containsKey(index)) {
//      final page = index / 20;
//      print('get podcast page ${page.toInt()}');
//      await _downloadPodcastsToCache(page.toInt());
//    }
//    if (!_cache.containsKey(index)) {
//      // TODO: The download failed, so you should probably provide a more
//      // meaningful error here.
//      throw Error();
//    }
//    return _cache[index];
//  }
//
//  /// Downloads a page of podcasts to the cache or just waits if the page is
//  /// already being downloaded.
//  Future<void> _downloadPodcastsToCache(int page) async {
//    if (!_downloaders.containsKey(page)) {
//      _downloaders[page] = _repository.getUpcomingMovies(page+1);
//      _downloaders[page].then((_) => _downloaders.remove(page));
//    }
//    final tempStore = await _downloaders[page];
//    for (int i = 0; i < tempStore.movies.length; i++) {
//      _cache[20 * page + i] = tempStore.movies[i];
//    }
//  }

  dispose(){
    _moviesImageProvider.close();
    _moviesPageScaleProvider.close();
    _moviesPagePositionProvider.close();
    _tvShowsImageProvider.close();
    _tvShowsPageScaleProvider.close();
    _tvShowsPagePositionProvider.close();
    _celebsImageProvider.close();
    _celebsPageScaleProvider.close();
    _celebsPagePositionProvider.close();
  }
}