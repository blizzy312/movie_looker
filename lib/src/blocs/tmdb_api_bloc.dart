import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/models/images_model.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/models/tv_show_model.dart';
import 'package:movie_looker/src/models/videos_model.dart';
import 'package:movie_looker/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TmdbApiBloc{
  final _repository = Repository();

  final _discoverMoviesProvider = BehaviorSubject<DiscoverMoviesModel>();
  final _discoverTvShowsProvider = BehaviorSubject<DiscoverTvShowsModel>();

  final _trendingMoviesProvider = BehaviorSubject<DiscoverMoviesModel>();
  final _mostPopularMoviesProvider = BehaviorSubject<DiscoverMoviesModel>();
  final _topRatedProvider = BehaviorSubject<DiscoverMoviesModel>();
  final _upcomingMoviesProvider = BehaviorSubject<DiscoverMoviesModel>();

  final _mostPopularTvShowsProvider = BehaviorSubject<DiscoverTvShowsModel>();
  final _topRatedTvShowsProvider = BehaviorSubject<DiscoverTvShowsModel>();

  final _mostPopularCelebritiesProvider = BehaviorSubject<CelebritiesModel>();

  final _movieProvider = PublishSubject<MovieModel>();
  final _castingProvider = PublishSubject<CastModel>();
  final _imagesProvider = PublishSubject<ImagesModel>();
  final _videosProvider = PublishSubject<VideosModel>();
  final _similarMoviesProvider = PublishSubject<DiscoverMoviesModel>();
  final _similarTvShowsProvider = PublishSubject<DiscoverTvShowsModel>();
  final _tvShowProvider = PublishSubject<TvShowModel>();

  Observable<DiscoverMoviesModel> get discoverMovies => _discoverMoviesProvider.stream;
  Observable<DiscoverTvShowsModel> get discoverTvShows => _discoverTvShowsProvider.stream;

  Observable<DiscoverMoviesModel> get trendingMovies => _trendingMoviesProvider.stream;
  Observable<DiscoverMoviesModel> get mostPopularMovies => _mostPopularMoviesProvider.stream;
  Observable<DiscoverMoviesModel> get topRatedMovies => _topRatedProvider.stream;
  Observable<DiscoverMoviesModel> get upcomingMovies => _upcomingMoviesProvider.stream;

  Observable<DiscoverTvShowsModel> get mostPopularTvShows => _mostPopularTvShowsProvider.stream;
  Observable<DiscoverTvShowsModel> get topRatedTvShows => _topRatedTvShowsProvider.stream;

  Observable<CelebritiesModel> get mostPopularCelebrities => _mostPopularCelebritiesProvider.stream;

  Observable<MovieModel> get fetchMovie => _movieProvider.stream;

  Observable<CastModel> get fetchMovieCasting => _castingProvider.stream;
  Observable<ImagesModel> get fetchImages => _imagesProvider.stream;
  Observable<VideosModel> get fetchVideos => _videosProvider.stream;

  Observable<DiscoverMoviesModel> get fetchSimilarMovies => _similarMoviesProvider.stream;
  Observable<DiscoverTvShowsModel> get fetchSimilarTvShows => _similarTvShowsProvider.stream;

  Observable<TvShowModel> get fetchTvShow => _tvShowProvider.stream;


  fetchDiscoverPage() async{
    _discoverMoviesProvider.sink.add(await _repository.getDiscoverMovies());
    _discoverTvShowsProvider.sink.add(await _repository.getDiscoverTvShows());
  }

  fetchMoviesPage() async {
    _trendingMoviesProvider.sink.add(await _repository.getTrendingMovies());
    _mostPopularMoviesProvider.sink.add(await _repository.getMostPopularMovies());
    _topRatedProvider.sink.add(await _repository.getTopRatedMovies());
    _upcomingMoviesProvider.sink.add(await _repository.getUpcomingMovies());
  }

  fetchTvShowPage() async {
    _mostPopularTvShowsProvider.sink.add(await _repository.getMostPopularTvShows());
    _topRatedTvShowsProvider.sink.add(await _repository.getTopRatedTvShows());
  }

  fetchCelebritiesPage() async {
    _mostPopularCelebritiesProvider.sink.add(await _repository.getMostPopularCelebrities());
  }

  fetchMovieByID(int movieID) async{
    _movieProvider.sink.add(await _repository.fetchMovie(movieID));
    _castingProvider.sink.add(await _repository.fetchMovieCasting(movieID));
    _imagesProvider.sink.add(await _repository.fetchMovieImages(movieID));
    _videosProvider.sink.add(await _repository.fetchMovieVideos(movieID));
    _similarMoviesProvider.sink.add(await _repository.fetchSimilarMovies(movieID));
  }

  fetchTvShowByID(int tvShowID) async{
    _tvShowProvider.sink.add(await _repository.fetchTvShow(tvShowID));
    _castingProvider.sink.add(await _repository.fetchTvShowCasting(tvShowID));
    _imagesProvider.sink.add(await _repository.fetchTvShowImages(tvShowID));
    _videosProvider.sink.add(await _repository.fetchTvShowVideos(tvShowID));
    _similarTvShowsProvider.sink.add(await _repository.fetchSimilarTvShows(tvShowID));
  }

//  fetchImagesByID(int id) async{
//    _imagesProvider.sink.add(await _repository.fetchMovieImages(id));
//  }


  onDispose(){
    _discoverMoviesProvider.close();
    _discoverTvShowsProvider.close();

    _trendingMoviesProvider.close();
    _mostPopularMoviesProvider.close();
    _topRatedProvider.close();
    _upcomingMoviesProvider.close();

    _mostPopularTvShowsProvider.close();
    _topRatedTvShowsProvider.close();

    _mostPopularCelebritiesProvider.close();

    _movieProvider.close();
    _castingProvider.close();
    _imagesProvider.close();
    _videosProvider.close();

    _similarMoviesProvider.close();
    _similarTvShowsProvider.close();

    _tvShowProvider.close();
  }
}
