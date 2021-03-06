import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/models/genre_model.dart';
import 'package:movie_looker/src/models/images_model.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/movie_details_model.dart';
import 'package:movie_looker/src/models/tv_show_detailed_model.dart';
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

  Future<List<GenreModel>> getMovieGenres() async{
    return await ApiProvider().getMovieGenres();
  }

  Future<DiscoverMoviesModel> getTrendingMovies() async {
    return await ApiProvider().getTrendingMovies();
  }

  Future<DiscoverMoviesModel> getMostPopularMoviesByPage(int page) async {
    return await ApiProvider().getMostPopularMoviesByPage(page);
  }

  Future<DiscoverMoviesModel> getTopRatedMoviesByPage(int page) async {
    return await ApiProvider().getTopRatedMoviesByPage(page);
  }

  Future<DiscoverMoviesModel> getUpcomingMoviesByPage(int page) async {
    return await ApiProvider().getUpcomingMoviesByPage(page);
  }

  Future<DiscoverTvShowsModel> getTrendingTvShows() async {
    return await ApiProvider().getTrendingTvShows();
  }

  Future<DiscoverTvShowsModel> getMostPopularTvShowsByPage(int page) async {
    return await ApiProvider().getMostPopularTvShowsByPage(page);
  }

  Future<DiscoverTvShowsModel> getTopRatedTvShowsByPage(int page) async {
    return await ApiProvider().getTopRatedTvShowsByPage(page);
  }

  Future<CelebritiesModel> getMostPopularCelebrities() async{
    return await ApiProvider().getMostPopularCelebrities();
  }

  Future<MovieDetailsModel> fetchMovie(int movieID) async{
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

  Future<TvShowDetailsModel> fetchTvShow(int tvShowID) async{
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