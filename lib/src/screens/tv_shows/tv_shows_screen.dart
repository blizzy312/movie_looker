import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/screens_control_bloc.dart';
import 'package:movie_looker/src/blocs/screens_control_bloc_provider.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/blocs/tv_shows_screen_bloc.dart';
import 'package:movie_looker/src/blocs/tv_shows_screen_bloc_provider.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_shows_see_all_screen.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';


class TvShowsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    final moviesScreenBloc = TvShowsScreenBlocProvider.of(context);
    moviesBloc.fetchTvShowPage();
    PageController pageController = PageController(
      keepPage: true,
      viewportFraction: 0.38,
      initialPage: moviesScreenBloc.getCurrentTvShowsPage().toInt() ?? 0,
    );
    pageController.addListener( () {
      moviesScreenBloc.pushTvShowsPagePosition(pageController.page);
    });
    return Scaffold(
      body: Container(
        color: Color(0xFF26252C),
        child: ListView(
          children: <Widget>[
            trendingTvShows(context, moviesBloc, moviesScreenBloc, pageController),
            SizedBox(height: 20,),
            mostPopularTvShows(context, moviesBloc),
            SizedBox(height: 20,),
            topRatedTvShows(context, moviesBloc),
          ],
        ),
      ),
    );
  }

  Widget trendingTvShows(BuildContext context, TmdbApiBloc moviesBloc, TvShowsScreenBloc moviesScreenBloc, PageController pageController){
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      color: Colors.transparent,
      child: StreamBuilder<DiscoverTvShowsModel>(
        stream: moviesBloc.trendingTvShows,
        builder: (context, AsyncSnapshot<DiscoverTvShowsModel> trendingSnapshot){
          if(!trendingSnapshot.hasData){
            return Container();
          }
          var tvShows = trendingSnapshot.data.tvShows;
          return StreamBuilder<double>(
            initialData: moviesScreenBloc.getCurrentTvShowsPage(),
            stream: moviesScreenBloc.getTvShowsPagePosition,
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
                      child: StreamBuilder(
                        stream: moviesScreenBloc.getTvShowsBackgroundImage,
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Transform.translate(
                              offset: Offset(0, -25),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${tvShows[pageController.initialPage].posterPath}',
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
                          moviesScreenBloc.setTvShowsBackgroundImage(tvShows[ind].posterPath);
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
                                  'https://image.tmdb.org/t/p/w500${tvShows[index].posterPath}',
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
                          '${tvShows[moviesScreenBloc.getCurrentTvShowsPage().roundToDouble().toInt()].name}',
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

  Widget mostPopularTvShows(BuildContext context, TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Most Popular',
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)
          => TvShowsSeeAllScreen (tvShowType: TvShowType.Popular,)
        ));
      },
      stream: moviesBloc.mostPopularTvShows,
      contentType: ContentType.TvShow,
      backgroundColor: Color(0xFF3A3940),
    );
  }

  Widget topRatedTvShows(BuildContext context, TmdbApiBloc moviesBloc){
    return CollectionOfMoviesWidget(
      title: 'Top Rated',
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)
          => TvShowsSeeAllScreen (tvShowType: TvShowType.TopRated,)
        ));
      },
      stream: moviesBloc.topRatedTvShows,
      contentType: ContentType.TvShow,
      backgroundColor: Color(0xFF3A3940),
    );
  }

}
