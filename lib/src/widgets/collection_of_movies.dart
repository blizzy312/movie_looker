import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/screens/movies/movie_details_screen.dart';
import 'package:movie_looker/src/screens/movies/upcoming_movie_details_screen.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_details_screen.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/movie_card.dart';
import 'package:movie_looker/src/widgets/tv_show_card.dart';


import 'loading_card.dart';

class CollectionOfMoviesWidget extends StatelessWidget {

  final String title;
  final Function onPressed;
  final Stream stream;
  final ContentType contentType;
  final MovieType type;
  final Color backgroundColor;

  CollectionOfMoviesWidget({this.title, this.type, this.stream, this.onPressed, this.backgroundColor, this.contentType});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: backgroundColor ?? Colors.transparent,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    onPressed();
                  },
                  child: Text(
                    "SEE ALL",
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                ),
              ],
            ),
          ),
          contentType == ContentType.Movie ?
          movieBuilder(moviesBloc)
            : contentType == ContentType.TvShow ?
            tvShowBuilder(moviesBloc)
            : celebsBuilder(moviesBloc),
        ],
      ),
    );
  }

  Widget movieBuilder(moviesBloc){
    return StreamBuilder<DiscoverMoviesModel>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<DiscoverMoviesModel> snapshot) {
        if(!snapshot.hasData){
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 16,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: <Widget>[
                    index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                    LoadingCard(),
                    SizedBox(
                      width: 15,
                    )
                  ],
                );
              },
            ),
          );
        }
        var movies = snapshot.data.movies;
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index){
              return Row(
                children: <Widget>[
                  index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                  GestureDetector(
                    onTap: (){
                      moviesBloc.fetchMovieByID(movies[index].id);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)
                        => type == MovieType.Normal ? MovieDetails( movieBloc: moviesBloc)
                          : UpcomingMovieDetails(movieBloc: moviesBloc,),
                      ));
                    },
                    child: MovieCard(
                      id: movies[index].id,
                      posterPath: movies[index].posterPath,
                      title: movies[index].title,
                      rating: movies[index].voteAverage,
                      type: type,
                      releaseDate: movies[index].releaseDate,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              );
            },
          ),
        );
      }
    );
  }

  Widget tvShowBuilder(TmdbApiBloc moviesBloc){
    return StreamBuilder<DiscoverTvShowsModel>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<DiscoverTvShowsModel> snapshot) {
        if(!snapshot.hasData){
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 16,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: <Widget>[
                    index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                    LoadingCard(),
                    SizedBox(
                      width: 15,
                    )
                  ],
                );
              },
            ),
          );
        }
        var movies = snapshot.data.tvShows;
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index){
              return Row(
                children: <Widget>[
                  index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                  GestureDetector(
                    onTap: (){
                      moviesBloc.fetchTvShowByID(movies[index].id);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)
                        => TvShowDetails(movieBloc: moviesBloc,)
                      ));
                    },
                    child: TvShowCard(
                      id: movies[index].id,
                      title: movies[index].name,
                      rating: movies[index].voteAverage,
                      posterPath: movies[index].posterPath,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              );
            },
          ),
        );
      }
    );
  }

  Widget celebsBuilder(moviesBloc){
    return StreamBuilder<CelebritiesModel>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<CelebritiesModel> snapshot) {
        if(!snapshot.hasData){
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 16,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: <Widget>[
                    index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                    LoadingCard(),
                    SizedBox(
                      width: 15,
                    )
                  ],
                );
              },
            ),
          );
        }
        var movies = snapshot.data.results;
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index){
              return Row(
                children: <Widget>[
                  index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
                  GestureDetector(
                    onTap: (){
//                      moviesBloc.fetchMovieByID(movies[index].id);
//                      Navigator.push(context, MaterialPageRoute(
//                        builder: (context)
//                        => type == MovieType.Normal ? MovieDetails( movieBloc: moviesBloc)
//                          : UpcomingMovieDetails(movieBloc: moviesBloc,),
//                      ));
                    },
                    child: MovieCard(
                      id: movies[index].id,
                      title: movies[index].name,
                      rating: movies[index].popularity.round(),
                      posterPath: movies[index].profilePath,
                      type: type,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              );
            },
          ),
        );
      }
    );
  }
}

//enum MovieType{
//  Normal, ComingSoon
//}
