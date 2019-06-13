import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_details_screen.dart';
import 'package:movie_looker/src/widgets/loading_card.dart';

import 'package:movie_looker/src/widgets/movie_card.dart';
import 'package:movie_looker/src/widgets/tv_show_card.dart';

class TvShowsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    moviesBloc.fetchTvShowPage();
    return Scaffold(
      body: Container(
        color: Color(0xFF011A27),
        child: ListView(
          children: <Widget>[
//            trendingTvShows(context, moviesBloc),
            SizedBox(height: 20,),
            mostPopularTvShows(context, moviesBloc),
            SizedBox(height: 20,),
            topRatedTvShows(context, moviesBloc),
          ],
        ),
      ),
    );
  }

//  Widget trendingTvShows(BuildContext context, TmdbApiBloc moviesBloc){
//    return
//  }

  Widget mostPopularTvShows(BuildContext context, TmdbApiBloc moviesBloc){
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Color(0xFF063872),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Popular Tv Shows",
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
          StreamBuilder<DiscoverTvShowsModel>(
            stream: moviesBloc.mostPopularTvShows,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 16,
                    itemBuilder: (context, index){
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
                            moviesBloc.fetchTvShowByID(movies[index].id);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetails( movieBloc: moviesBloc)));
                          },
                          child: TvShowCard(
                            id: movies[index].id,
                            posterPath: movies[index].posterPath,
                            title: movies[index].name,
                            rating: movies[index].voteAverage,

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

  Widget topRatedTvShows(BuildContext context, TmdbApiBloc moviesBloc){
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Color(0xFF355B8C),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Top Rated Movies",
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
          StreamBuilder<DiscoverTvShowsModel>(
            stream: moviesBloc.topRatedTvShows,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 16,
                    itemBuilder: (context, index){
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
                            moviesBloc.fetchTvShowByID(movies[index].id);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetails( movieBloc: moviesBloc)));
                          },
                          child: MovieCard(
                            id: movies[index].id,
                            posterPath: movies[index].posterPath,
                            title: movies[index].name,
                            rating: movies[index].voteAverage,
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
