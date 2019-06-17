import 'package:movie_looker/src/models/movie_model.dart';

class DiscoverMoviesModel {
  int page;
  int totalResults;
  int totalPages;
  List<MovieModel> movies;

  DiscoverMoviesModel({this.page, this.totalResults, this.totalPages, this.movies});

  DiscoverMoviesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = new List<MovieModel>();
      json['results'].forEach((v) {
        movies.add(new MovieModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

