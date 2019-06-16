import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/models/images_model.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/models/tv_show_model.dart';
import 'package:movie_looker/src/models/videos_model.dart';

import 'api_provider.dart';

class Repository{


  Future<String> guestLogin(){
    return ApiProvider().guestLogin();
  }

  Future<DiscoverMoviesModel> getDiscoverMovies() async{
    return await ApiProvider().getDiscoverMovies();
  }

  Future<DiscoverTvShowsModel> getDiscoverTvShows() async{
    return await ApiProvider().getDiscoverTvShows();
  }

  Future<DiscoverMoviesModel> getTrendingMovies() async {
    return await ApiProvider().getTrendingMovies();
  }

  Future<DiscoverMoviesModel> getMostPopularMovies() async {
    return await ApiProvider().getMostPopularMovies();
  }

  Future<DiscoverMoviesModel> getTopRatedMovies() async {
    return await ApiProvider().getTopRatedMovies();
  }

  Future<DiscoverMoviesModel> getUpcomingMovies() async {
    return await ApiProvider().getUpcomingMovies();
  }

  Future<DiscoverTvShowsModel> getTrendingTvShows() async {
    return await ApiProvider().getTrendingTvShows();
  }

  Future<DiscoverTvShowsModel> getMostPopularTvShows() async {
    return await ApiProvider().getMostPopularTvShows();
  }

  Future<DiscoverTvShowsModel> getTopRatedTvShows() async {
    return await ApiProvider().getTopRatedTvShows();
  }

  Future<CelebritiesModel> getMostPopularCelebrities() async{
    return await ApiProvider().getMostPopularCelebrities();
  }

  Future<MovieModel> fetchMovie(int movieID) async{
    return await ApiProvider().getMovie(movieID);
  }

  Future<CastModel> fetchMovieCasting(int movieID) async{
    return await ApiProvider().getMovieCasting(movieID);
  }

  Future<ImagesModel> fetchMovieImages(int movieID) async{
    return await ApiProvider().getMovieImages(movieID);
  }

  Future<VideosModel> fetchMovieVideos(int movieID) async{
    return await ApiProvider().getMovieVideos(movieID);
  }

  Future<DiscoverMoviesModel> fetchSimilarMovies(int movieID) async{
    return await ApiProvider().getSimilarMovies(movieID);
  }

  Future<TvShowModel> fetchTvShow(int tvShowID) async{
    return await ApiProvider().getTvShow(tvShowID);
  }

  Future<CastModel> fetchTvShowCasting(int tvShowID) async{
    return await ApiProvider().getTvShowCast(tvShowID);
  }

  Future<ImagesModel> fetchTvShowImages(int tvShowID) async{
    return await ApiProvider().getTvShowImages(tvShowID);
  }

  Future<VideosModel> fetchTvShowVideos(int tvShowID) async{
    return await ApiProvider().getTvShowVideos(tvShowID);
  }

  Future<DiscoverTvShowsModel> fetchSimilarTvShows(int tvShowID) async{
    return await ApiProvider().getSimilarTvShows(tvShowID);
  }

  Future<CelebritiesModel> getTrendingCelebrities() async {
    return await ApiProvider().getTrendingCelebrities();
  }
}