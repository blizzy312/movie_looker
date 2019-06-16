import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/screens_control_bloc.dart';
import 'package:movie_looker/src/blocs/screens_control_bloc_provider.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/celebrities_model.dart';
import 'package:movie_looker/src/screens/movies/movie_details_screen.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';

import 'package:movie_looker/src/widgets/movie_card.dart';


class CelebritiesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    final moviesScreenBloc = ScreensControlProvider.of(context);
    moviesBloc.fetchCelebritiesPage();
    PageController pageController = PageController(
      keepPage: true,
      viewportFraction: 0.38,
      initialPage: moviesScreenBloc.getCurrentCelebsPage().toInt() ?? 0,
    );
    pageController.addListener( () {
      moviesScreenBloc.pushCelebsPagePosition(pageController.page);
    });
    return Scaffold(
      body: Container(
        color: Colors.black54,
        child: ListView(
          children: <Widget>[
            trendingCelebs(context, moviesBloc, moviesScreenBloc, pageController),
            SizedBox(height: 20,),
            popularCelebrities(context, moviesBloc),
          ],
        ),
      ),
    );
  }

  Widget trendingCelebs(BuildContext context, TmdbApiBloc moviesBloc, ScreensControlBloc moviesScreenBloc, PageController pageController){
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      color: Colors.transparent,
      child: StreamBuilder<CelebritiesModel>(
        stream: moviesBloc.trendingCelebrities,
        builder: (context, AsyncSnapshot<CelebritiesModel> trendingSnapshot){
          if(!trendingSnapshot.hasData){
            return Container();
          }
          var tvShows = trendingSnapshot.data.results;
          return StreamBuilder<double>(
            initialData: moviesScreenBloc.getCurrentCelebsPage(),
            stream: moviesScreenBloc.getCelebsPagePosition,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Container();
              }
              return Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: ShaderMask(
                      child: !snapshot.hasData ? Transform.translate(
                              offset: Offset(0, -25),
                              child: movieImages(tvShows[pageController.initialPage].knownFor, moviesBloc),
                            ) : Transform.translate(
                              offset: Offset(0, -25),
                              child: movieImages(tvShows[snapshot.data.round()].knownFor, moviesBloc),
                            ),
//                      child: StreamBuilder(
//                        stream: moviesScreenBloc.getCelebsBackgroundImage,
//                        builder: (context, snapshot){
//                          if(!snapshot.hasData){
//                            return Transform.translate(
//                              offset: Offset(0, -25),
//                              child: movieImages(tvShows[pageController.initialPage].knownFor),
////                              child: Image.network(
////                                'https://image.tmdb.org/t/p/w500${tvShows[pageController.initialPage].profilePath}',
////                                width: double.infinity,
////                                fit: BoxFit.fitWidth,
////                              ),
//                            );
//                          }
//                          return Transform.translate(
//                            offset: Offset(0, -25),
//                            child: movieImages(tvShows[snapshot.].knownFor),
////                            child: Image.network(
////                              'https://image.tmdb.org/t/p/w500${snapshot.data}',
////                              width: double.infinity,
////                              fit: BoxFit.fitWidth,
////                              alignment: Alignment.topCenter,
////                            ),
//                          );
//                        }
//                      ),
                      shaderCallback: (Rect bounds){
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xFF26252C),
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
                        itemCount: tvShows.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (ind) {
                          moviesScreenBloc.setCelebsBackgroundImage(tvShows[ind].profilePath);
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
                                  'https://image.tmdb.org/t/p/w500${tvShows[index].profilePath}',
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
                          '${tvShows[moviesScreenBloc.getCurrentCelebsPage().roundToDouble().toInt()].name}',
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


  Widget popularCelebrities(BuildContext context, TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Most Popular',
      onPressed: null,
      stream: moviesBloc.mostPopularCelebrities,
      contentType: ContentType.Celeb,
      type: MovieType.Normal,
      backgroundColor: Color(0xFF3A3940),
    );
  }

  Widget movieImages(List<KnownFor> references, moviesBloc){
    PageController controller = PageController(initialPage: 0);
    return PageView.builder(

      controller: controller,
      itemCount: references.length,
      itemBuilder: (context, index){
        if(index > 2) {
          index -= 3;
        } else if(index < 0){
          index += 3;
        }
        return GestureDetector(
          onTap: (){
            moviesBloc.fetchMovieByID(references[index].id);
            Navigator.push(context, MaterialPageRoute(
              builder: (context)
              => MovieDetails( movieBloc: moviesBloc)

            ));
          },
          child: Image.network(
            'https://image.tmdb.org/t/p/w300${references[index].posterPath}',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        );
      }
    );
  }

}
