import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/screens/movies/movie_details_screen.dart';
import 'package:movie_looker/src/screens/movies/upcoming_movie_details_screen.dart';
import 'package:movie_looker/src/widgets/movie_card.dart';


import 'loading_card.dart';

class CollectionOfMoviesWidget extends StatelessWidget {

  final String title;
  final Function onPressed;
  final Stream stream;
  final MovieType type;
  final Color backgroundColor;

  CollectionOfMoviesWidget({this.title, this.type, this.stream, this.onPressed, this.backgroundColor});

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
          StreamBuilder<DiscoverMoviesModel>(
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
                            moviesBloc.fetchMovieByID(movies[index].id);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)
                              => type == MovieType.Normal ? MovieDetails( movieBloc: moviesBloc)
                                : UpcomingMovieDetails(movieBloc: moviesBloc,),
                            ));
                          },
//                          child: type == MovieType.Normal ?
//                          MovieCard(
//                            id: movies[index].id,
//                            posterPath: movies[index].posterPath,
//                            title: movies[index].title,
//                            rating: movies[index].voteAverage,
//                          ) : UpcomingMovieCard(
//                            id: movies[index].id,
//                            posterPath: movies[index].posterPath,
//                            title: movies[index].title,
//                            releaseDate: movies[index].releaseDate,
//                          ),
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
          ),
        ],
      ),
    );
  }

}

enum MovieType{
  Normal, ComingSoon
}
