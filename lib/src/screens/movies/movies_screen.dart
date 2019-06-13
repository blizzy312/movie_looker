import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc_provider.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/discover_movies_model.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';


class MoviesScreen extends StatelessWidget {

  final SCALE_FRACTION = 0.7;
  final FULL_SCALE = 1.0;

  final double viewPortFraction = 0.35;

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    final moviesScreenBloc = MoviesScreenProvider.of(context);
    moviesBloc.fetchMoviesPage();
    PageController pageController = PageController(
      keepPage: true,
      viewportFraction: 0.38,
      initialPage: moviesScreenBloc.moviesCurrentPageNum.toInt(),
    );
    pageController.addListener( () {
      moviesScreenBloc.pushMoviesPagePosition(pageController.page);
    });
    return Scaffold(
      body: Container(
        color: Color(0xFF26252C),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            trendingMovies(context, moviesBloc, moviesScreenBloc, pageController),
            SizedBox(height: 20,),
            upcomingMovies(moviesBloc),
            SizedBox(height: 20,),
            mostPopularMovies(moviesBloc),
            SizedBox(height: 20,),
            topRatedMovies(moviesBloc),
          ],
        ),
      ),
    );
  }

  Widget trendingMovies(BuildContext context, TmdbApiBloc moviesBloc, MoviesScreenBloc moviesScreenBloc, PageController pageController){
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      color: Colors.transparent,
      child: StreamBuilder<DiscoverMoviesModel>(
        stream: moviesBloc.trendingMovies,
        builder: (context, AsyncSnapshot<DiscoverMoviesModel> trendingSnapshot){
          if(!trendingSnapshot.hasData){
            return Container();
          }
          var movies = trendingSnapshot.data.results;
          return StreamBuilder<double>(
            initialData: moviesScreenBloc.moviesCurrentPageNum,
            stream: moviesScreenBloc.getMoviesPagePosition,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Container();
              }
              print('data from streambuilder ${snapshot.data}');
              print(movies[moviesScreenBloc.moviesCurrentPageNum.toInt()].title);
              return Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: ShaderMask(
                      child: StreamBuilder(
                        stream: moviesScreenBloc.getBackgroundImage,
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Transform.translate(
                              offset: Offset(0, -25),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movies[pageController.initialPage].posterPath}',
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          }
                          return Transform.translate(
                            offset: Offset(0, -25),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${snapshot.data}',
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          );
                        }
                      ),
                      shaderCallback: (Rect bounds){
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xFF26252C),
//                            Colors.transparent
                          ],
                          stops: [0.5, 0.85]
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: PageView.builder(
                        itemCount: movies.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (ind) {
                          moviesScreenBloc.setBackgroundImage(movies[ind].posterPath);
                          moviesScreenBloc.changeMoviesPageNum(ind.toDouble());
                        },
                        controller: pageController,
                        itemBuilder: (context, index){
                          double scale =
                          max( 0.8, (1.2 - (index - snapshot.data).abs()) +
                            0.3);
                          return AnimatedBuilder(
                            animation: pageController,
                            builder: (context, child){
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Transform.scale(
                                  scale: scale >= 1.2 ? 1.2 : scale,
                                  child: child,
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      child: Center(
                        child: Text(
                          '${movies[moviesScreenBloc.moviesCurrentPageNum.toInt()].title}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }

  Widget mostPopularMovies(TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Most Popular',
      onPressed: null,
      stream: moviesBloc.mostPopularMovies,
      type: MovieType.Normal,
      backgroundColor: Color(0xFF3A3940),
    );
  }

  Widget topRatedMovies(TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Top rated',
      onPressed: null,
      stream: moviesBloc.topRatedMovies,
      type: MovieType.Normal,
      backgroundColor: Color(0xFF3A3940),
    );
  }

  Widget upcomingMovies(TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Coming soon',
      onPressed: null,
      stream: moviesBloc.upcomingMovies,
      type: MovieType.ComingSoon,
      backgroundColor: Color(0xFF3A3940),
    );
  }

}

