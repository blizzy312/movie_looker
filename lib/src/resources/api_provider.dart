import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/models/genre_model.dart';
import 'package:movie_looker/src/models/images_model.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/movie_details_model.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/tv_show_detailed_model.dart';
import 'package:movie_looker/src/models/videos_model.dart';

class ApiProvider{
  final _rootAddress = 'https://api.themoviedb.org/3';
  final _apiKey = '467e0821029c1f28d7a6f61e0e1c851e';
  Client client = Client();

  Future<String> guestLogin() async{
    final response = await client.get('$_rootAddress/authentication/guest_session/new?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return temp.toString();
  }

  Future<DiscoverMoviesModel> getDiscoverMovies() async{
    final response = await client.get('$_rootAddress/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1');
    final temp = json.decode(response.body);
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<DiscoverTvShowsModel> getDiscoverTvShows() async{
    final response = await client.get('$_rootAddress/discover/tv?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false');
    final temp = json.decode(response.body);
    return DiscoverTvShowsModel.fromJson(temp);
  }

  Future<List<GenreModel>> getMovieGenres() async{
    final response = await client.get('$_rootAddress/genre/movie/list?api_key=$_apiKey&language=en-US');
    final temp = json.decode(response.body);
    List<GenreModel> genres = [];

    if (temp['genres'] != null) {
      genres = new List<GenreModel>();
      temp['genres'].forEach((v) {
        genres.add(new GenreModel.fromJson(v));
      });
    }
    return genres;
  }

  Future<DiscoverMoviesModel> getTrendingMovies() async{
    final response = await client.get('$_rootAddress/trending/movie/week?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<DiscoverMoviesModel> getMostPopularMoviesByPage(int page) async {
    final response = await client.get('$_rootAddress/movie/popular?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final temp = json.decode(response.body);
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<DiscoverMoviesModel> getTopRatedMoviesByPage(int page) async {
    final response = await client.get('$_rootAddress/movie/top_rated?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final temp = json.decode(response.body);
    print('topRated API $temp');
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<DiscoverMoviesModel> getUpcomingMoviesByPage(int page) async {
    final response = await client.get('$_rootAddress/movie/upcoming?api_key=$_apiKey&language=en-US&region=US&page=$page');
    final temp = json.decode(response.body);
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<DiscoverTvShowsModel> getTrendingTvShows() async{
    final response = await client.get('$_rootAddress/trending/tv/week?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return DiscoverTvShowsModel.fromJson(temp);
  }

  Future<DiscoverTvShowsModel> getMostPopularTvShowsByPage(int page) async {
    final response = await client.get('$_rootAddress/tv/popular?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final temp = json.decode(response.body);
    return DiscoverTvShowsModel.fromJson(temp);
  }

  Future<DiscoverTvShowsModel> getTopRatedTvShowsByPage(int page) async {
    final response = await client.get('$_rootAddress/tv/top_rated?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final temp = json.decode(response.body);
    return DiscoverTvShowsModel.fromJson(temp);
  }


  Future<MovieDetailsModel> getMovie(int movieID) async{
    final response = await client.get('$_rootAddress/movie/$movieID?api_key=$_apiKey&language=en-US&region=US');
    final temp = json.decode(response.body);
    return MovieDetailsModel.fromJson(temp);
  }

  Future<CastModel> getMovieCasting(int movieID) async{
    final response = await client.get('$_rootAddress/movie/$movieID/casts?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return CastModel.fromJson(temp);
  }

  Future<ImagesModel> getMovieImages(int movieID) async{
    final response = await client.get('$_rootAddress/movie/$movieID/images?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return ImagesModel.fromJson(temp);
  }

  Future<VideosModel> getMovieVideos(int movieID) async{
    final response = await client.get('$_rootAddress/movie/$movieID/videos?api_key=$_apiKey&language=en-US');
    final temp = json.decode(response.body);
    return VideosModel.fromJson(temp);
  }

  Future<DiscoverMoviesModel> getSimilarMovies(int movieID) async {
    final response = await client.get('$_rootAddress/movie/$movieID/similar?api_key=$_apiKey&language=en-US&page=1');
    final temp = json.decode(response.body);
    return DiscoverMoviesModel.fromJson(temp);
  }

  Future<TvShowDetailsModel> getTvShow(int tvShowID) async{
    final response = await client.get('$_rootAddress/tv/$tvShowID?api_key=$_apiKey&language=en-US');
    final temp = json.decode(response.body);
    return TvShowDetailsModel.fromJson(temp);
  }

  Future<CastModel> getTvShowCast(int tvShowID) async{
    final response = await client.get('$_rootAddress/tv/$tvShowID/credits?api_key=$_apiKey');
//    https://api.themoviedb.org/3/tv/63926/credits?api_key=467e0821029c1f28d7a6f61e0e1c851e
    final temp = json.decode(response.body);
    return CastModel.fromJson(temp);
  }

  Future<ImagesModel> getTvShowImages(int tvShowID) async{
    final response = await client.get('$_rootAddress/tv/$tvShowID/images?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return ImagesModel.fromJson(temp);
  }

  Future<VideosModel> getTvShowVideos(int tvShowID) async{
    final response = await client.get('$_rootAddress/tv/$tvShowID/videos?api_key=$_apiKey&language=en-US');
    final temp = json.decode(response.body);
    return VideosModel.fromJson(temp);
  }

  Future<DiscoverTvShowsModel> getSimilarTvShows(int tvShowID) async {
    final response = await client.get('$_rootAddress/tv/$tvShowID/similar?api_key=$_apiKey&language=en-US&page=1');
    final temp = json.decode(response.body);
    return DiscoverTvShowsModel.fromJson(temp);
  }

  Future<CelebritiesModel> getMostPopularCelebrities() async {
    final response = await client.get('$_rootAddress/person/popular?api_key=$_apiKey&language=en-US&page=1');
    final temp = json.decode(response.body);
    print(temp);
    return CelebritiesModel.fromJson(temp);
  }

  Future<CelebritiesModel> getTrendingCelebrities() async{
    final response = await client.get('$_rootAddress/trending/person/week?api_key=$_apiKey');
    final temp = json.decode(response.body);
    return CelebritiesModel.fromJson(temp);
  }

}