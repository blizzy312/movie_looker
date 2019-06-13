import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/discover_screen_bloc_provider.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/widgets/animated_movie_card.dart';
import 'package:movie_looker/src/widgets/discover_movie_card.dart';

import 'package:movie_looker/src/screens/movies/movie_details_screen.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_details_screen.dart';

class DiscoverScreen extends StatelessWidget {

  final PageController moviesPageController = PageController(viewportFraction: 0.55);
  final PageController tvPageController = PageController(viewportFraction: 0.55);

  final SCALE_FRACTION = 0.7;
  final FULL_SCALE = 1.0;

  final double viewPortFraction = 0.5;


  @override
  Widget build(BuildContext context) {
    final movieBloc = TmdbApiProvider.of(context);
    final discoverScreenBloc = DiscoverScreenBlocProvider.of(context);
    movieBloc.fetchDiscoverPage();
    moviesPageController.addListener( () {
      discoverScreenBloc.pushMoviesPagePosition(moviesPageController.page);
    });
    tvPageController.addListener( () {
      discoverScreenBloc.pushTvPagePosition(tvPageController.page);
    });
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only( left: 15, top: 15),
            child: Text(
              'Movies',
              style: TextStyle(
                fontSize: 25
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: StreamBuilder<DiscoverMoviesModel>(
              stream: movieBloc.discoverMovies,
              builder: (context, AsyncSnapshot<DiscoverMoviesModel> discoverSnapshot) {
                if(!discoverSnapshot.hasData){
                  return Container();
                }
                var moviesSnapshot = discoverSnapshot.data.results;
                return StreamBuilder<double>(
                  initialData: discoverScreenBloc.pushMoviesPagePosition(discoverScreenBloc.moviesCurrentPageNum),
                  stream: discoverScreenBloc.getMoviesPagePosition,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Container();
                    }
                    return PageView.builder(
                      onPageChanged: (value) {
                        discoverScreenBloc.changeMoviesPageNum(value.toDouble());
                      },
                      controller: moviesPageController,
                      itemCount: moviesSnapshot.length,
                      itemBuilder: (context, index) {
                        double scale =
                        max(SCALE_FRACTION,
                          (FULL_SCALE - (index - snapshot.data).abs()) +
                            viewPortFraction);
                        print((FULL_SCALE - (index - snapshot.data).abs()));
                        return GestureDetector(
                          onTap: (){
                            movieBloc.fetchMovieByID(moviesSnapshot[index].id);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails( movieBloc: movieBloc)));
                          },
                          child: AnimatedMovieCard(
                            scale: scale <= 1.0 ? scale : 1.0,
                            content: DiscoverMovieCard(
                              id: moviesSnapshot[index].id,
                              imageScale: scale >= 1.5 ? 1.0 : (1.0 + (1.5 - scale)),
                              posterPath: moviesSnapshot[index].posterPath,
                              title: moviesSnapshot[index].title,
                            ),
                          ),
                        );
                      }
                    );
                  }
                );
              }
            )),
          Padding(
            padding: const EdgeInsets.only( left: 15, top: 25),
            child: Text(
              'TV shows',
              style: TextStyle(
                fontSize: 25
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: StreamBuilder<DiscoverTvShowsModel>(
              stream: movieBloc.discoverTvShows,
              builder: (context, AsyncSnapshot<DiscoverTvShowsModel> discoverSnapshot) {
                if(!discoverSnapshot.hasData){
                  return Container();
                }
                var tvShowsSnapshot = discoverSnapshot.data.results;
                return StreamBuilder<double>(
                  initialData: discoverScreenBloc.pushTvPagePosition(discoverScreenBloc.tvCurrentPageNum),
                  stream: discoverScreenBloc.getTvPagePosition,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Container();
                    }
                    return PageView.builder(
                      onPageChanged: (value) {
                        discoverScreenBloc.changeTvPageNum(value.toDouble());
                      },
                      controller: tvPageController,
                      itemCount: tvShowsSnapshot.length,
                      itemBuilder: (context, index) {
                        double scale =
                        max(SCALE_FRACTION,
                          (FULL_SCALE - (index - snapshot.data).abs()) +
                            viewPortFraction);
                        return GestureDetector(
                          onTap: (){
                            movieBloc.fetchTvShowByID(tvShowsSnapshot[index].id);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetails( movieBloc: movieBloc)));
                          },
                          child: Hero(
                            tag: tvShowsSnapshot[index].id,
                            child: AnimatedMovieCard(
                              scale: scale <= 1.0 ? scale : 1.0,
                              content: DiscoverMovieCard(
                                id: tvShowsSnapshot[index].id,
                                imageScale: scale >= 1.5 ? 1.0 : (1.0 + (1.5 - scale)),
                                posterPath: tvShowsSnapshot[index].posterPath,
                                title: tvShowsSnapshot[index].name,
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  }
                );
              }
            )),
        ],
      ),
    );
  }
}
