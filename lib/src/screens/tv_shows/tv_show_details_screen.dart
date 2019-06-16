import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';
import 'package:movie_looker/src/widgets/loading_card.dart';
import 'package:movie_looker/src/widgets/movie_card.dart';
import 'package:youtube_player/youtube_player.dart';

import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/tv_show_model.dart';
import 'package:movie_looker/src/models/videos_model.dart';
import 'package:movie_looker/src/widgets/casting_actor_card.dart';
import 'package:movie_looker/src/widgets/genres_widget.dart';



class TvShowDetails extends StatelessWidget {
  final TmdbApiBloc movieBloc;

  final double smallFontSize = 10.0;
  final double bigFontSize = 25.0;

  TvShowDetails({this.movieBloc});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<TvShowModel>(
        stream: movieBloc.fetchTvShow,
        builder: (context, AsyncSnapshot<TvShowModel> tvShowSnapshot) {
          if(!tvShowSnapshot.hasData){
            return Container();
          }
          TvShowModel currentTvShow = tvShowSnapshot.data;
          return ListView(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -25),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height:MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: Hero(
                        tag: currentTvShow.id,
                        child: ShaderMask(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${currentTvShow.posterPath}',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          shaderCallback: (Rect bounds){
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.indigo[900]
                              ],
                              stops: [0.0, 0.95]
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      right: 15,
                      child: getTitleInfo(context, currentTvShow),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -25),
                child: getDetails(context, currentTvShow)
              ),
            ],
          );
        }
      )
    );
  }

  Widget getTitleInfo(context, TvShowModel currentTvShow){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            '${currentTvShow.name.toUpperCase()}',
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
        ),
        getRatingsRow(currentTvShow.voteAverage.toDouble()),
        SizedBox(height: 5,),
        GenresWidgets(genres: currentTvShow.genres,)
      ],
    );
  }

  Widget getRatingsRow(double rating){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$rating',
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10,),
        FlutterRatingBarIndicator(
          itemSize: 20,
          rating: modifyRating(rating),
          emptyColor: Color(0x65FFFFFF),
          fillColor: Color(0xFFFFD700),
        ),
      ],
    );
  }

  Widget getDetails(context, TvShowModel currentTvShow){
    return Container(
      color: Color(0xFF1D2840),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          getMovieParameters(currentTvShow),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'STORYLINE',
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${currentTvShow.overview}',
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Color(0xFF8A93A6),
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          getCasting(context),
          SizedBox(
            height: 15,
          ),
          getVideos(context),
          SizedBox(
            height: 15,
          ),
          getSimilarTvShows(context),
        ],
      ),
    );
  }

  Widget getMovieParameters(TvShowModel currentTvShow){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'LANGUAGE',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  '${currentTvShow.originalLanguage.toUpperCase()}',
                  style: TextStyle(
                    fontSize: bigFontSize,
                    color: Color(0xFF8A93A6),
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'STATUS',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  currentTvShow.status == 'Ended' ? '${currentTvShow.status}' : 'Cont',
                  style: TextStyle(
                    fontSize: bigFontSize,
                    color: Color(0xFF8A93A6),
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'SEASONS',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${currentTvShow.numberOfSeasons}',
                  style: TextStyle(
                    fontSize: bigFontSize,
                    color: Color(0xFF8A93A6),
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'EPISODES',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${currentTvShow.numberOfEpisodes}',
                  style: TextStyle(
                    fontSize: bigFontSize,
                    color: Color(0xFF8A93A6),
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCasting(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'CAST',
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: StreamBuilder(
            stream: movieBloc.fetchMovieCasting,
            builder: (context, AsyncSnapshot<CastModel> castingSnapshot){
              if(!castingSnapshot.hasData){
                return Container();
              }
              List<Cast> casting = castingSnapshot.data.cast;
              return ListView.builder(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                itemCount: casting.length,
                itemBuilder: (context, index){
                  return CastingActorCard(actor: casting[index]);
                }
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getVideos(BuildContext context){
    return StreamBuilder<VideosModel>(
      stream: movieBloc.fetchVideos,
      builder: (context, AsyncSnapshot<VideosModel> videosSnapshot) {
        if(!videosSnapshot.hasData || videosSnapshot.data.results.length == 0){
          return SizedBox();
        }
        List<VideoModel> videos = videosSnapshot.data.results;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'VIDEOS ${videos.length}',
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
//            Container(
//              height: MediaQuery.of(context).size.height * 0.35,
//              child: ListView.builder(
//                padding: EdgeInsets.only(left: 5),
//                scrollDirection: Axis.horizontal,
//                itemCount: videos.length,
//                itemBuilder: (context, index) {
//                  return Container(
//                    margin: EdgeInsets.all(10),
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(10),
//                      child: YoutubePlayer(
//                        context: context,
//                        source: videos[index].key,
//                        quality: YoutubeQuality.HD,
//                        autoPlay: false,
//                        hideShareButton: true,
//                        reactToOrientationChange: false,
//                      )
//                    ),
//                  );
//                }
//              ),
//            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: PageView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: YoutubePlayer(
                        context: context,
                        source: videos[index].key,
                        quality: YoutubeQuality.HD,
                        autoPlay: false,
                        hideShareButton: true,
                        reactToOrientationChange: false,
                      )
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }

  Widget getSimilarTvShows(BuildContext context){
//    return Container(
//      height: MediaQuery.of(context).size.height * 0.55,
//      color: Colors.transparent,
//      child: Column(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Text(
//                    "SEE ALSO",
//                    style: TextStyle(
//                      fontSize: 25,
//                      color: Colors.white,
//                      fontWeight: FontWeight.w400,
//                    ),
//                  ),
//                ),
//                FlatButton(
//                  onPressed: (){
//
//                  },
//                  child: Text(
//                    "SEE ALL",
//                    style: TextStyle(
//                      color: Colors.blue
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          StreamBuilder<DiscoverTvShowsModel>(
//            stream: movieBloc.fetchSimilarTvShows,
//            builder: (context, snapshot) {
//              if(!snapshot.hasData){
//                return Container(
//                  height: MediaQuery.of(context).size.height * 0.4,
//                  width: double.infinity,
//                  child: ListView.builder(
//                    scrollDirection: Axis.horizontal,
//                    itemCount: 16,
//                    itemBuilder: (context, index){
//                      return Row(
//                        children: <Widget>[
//                          index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
//                          LoadingCard(),
//                          SizedBox(
//                            width: 15,
//                          )
//                        ],
//                      );
//                    },
//                  ),
//                );
//              }
//              var movies = snapshot.data.results;
//              return Container(
//                height: MediaQuery.of(context).size.height * 0.4,
//                width: double.infinity,
//                child: ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  itemCount: movies.length ?? 0,
//                  itemBuilder: (context, index){
//                    return Row(
//                      children: <Widget>[
//                        index == 0 ? SizedBox(width: 15,) : SizedBox(width: 0),
//                        GestureDetector(
//                          onTap: (){
//                            movieBloc.fetchMovieByID(movies[index].id);
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetails( movieBloc: movieBloc)));
//                          },
//                          child: MovieCard(
//                            id: movies[index].id,
//                            posterPath: movies[index].posterPath,
//                            title: movies[index].name,
//                            rating: movies[index].voteAverage,
//                          ),
//                        ),
//                        SizedBox(
//                          width: 15,
//                        )
//                      ],
//                    );
//                  },
//                ),
//              );
//            }
//          ),
//        ],
//      ),
//    );
    return CollectionOfMoviesWidget(
      title: 'See also',
      onPressed: null,
      stream: movieBloc.fetchSimilarTvShows,
      contentType: ContentType.TvShow,
      backgroundColor: Color(0xFF3A3940),
    );
  }

  double modifyRating(double rating){
    return (5 * rating.round()) / 10;
  }
}
