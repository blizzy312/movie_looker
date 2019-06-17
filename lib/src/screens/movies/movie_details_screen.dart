import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';


import 'package:youtube_player/youtube_player.dart';

import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/models/images_model.dart';
import 'package:movie_looker/src/models/cast_model.dart';
import 'package:movie_looker/src/models/movie_details_model.dart';
import 'package:movie_looker/src/models/videos_model.dart';
import 'package:movie_looker/src/widgets/casting_actor_card.dart';
import 'package:movie_looker/src/widgets/genres_widget.dart';



class MovieDetails extends StatelessWidget {
  final TmdbApiBloc movieBloc;

  final double smallFontSize = 10.0;
  final double bigFontSize = 25.0;


  MovieDetails({this.movieBloc});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF1D2840),
      body: StreamBuilder<MovieDetailsModel>(
        stream: movieBloc.fetchMovie,
        builder: (context, AsyncSnapshot<MovieDetailsModel> movieSnapshot) {
          if(!movieSnapshot.hasData){
            return Container();
          }

          MovieDetailsModel currentMovie = movieSnapshot.data;

          return ListView(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -25),
                child: Stack(
                  children: <Widget>[
                    backgroundImage(context, currentMovie.posterPath),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      right: 15,
                      child: getTitleInfo(context, currentMovie),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -20),
                child: getDetails(context, currentMovie)
              ),
            ],
          );
        }
      )
    );
  }

  Widget backgroundImage(BuildContext context, String posterPath){
    return Container(
      height:MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: ShaderMask(
        child: Image.network(
          'https://image.tmdb.org/t/p/w500$posterPath',
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
    );
  }

  Widget getTitleInfo(context, MovieDetailsModel currentMovie){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            '${currentMovie.title.toUpperCase()}',
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
        ),
        getRatingsRow(currentMovie.voteAverage.toDouble()),
        SizedBox(height: 5,),
        GenresWidgets(genres: currentMovie.genres,)
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

  Widget getDetails(context, MovieDetailsModel currentMovie){
    return Container(
      color: Color(0xFF1D2840),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          getMovieInfo(currentMovie),
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
              '${currentMovie.overview}',
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
          getImages(context),
          SizedBox(
            height: 15,
          ),
          getVideos(context),
          SizedBox(
            height: 15,
          ),
          getSimilarMovies(),
        ],
      ),
    );
  }

  Widget getMovieInfo(MovieDetailsModel currentMovie){
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
                  '${currentMovie.originalLanguage.toUpperCase()}',
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
                  'VOTE',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${currentMovie.voteCount}',
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
                  'LENGTH',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                currentMovie.runtime == null ?
                Text(
                  '-',
                  style: TextStyle(
                    fontSize: bigFontSize,
                    color: Color(0xFF8A93A6),
                  ),
                ) : RichText(
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: new TextStyle(
                      fontSize: bigFontSize,
                      color: Color(0xFF8A93A6),
                      fontWeight: FontWeight.bold
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: '${currentMovie.runtime~/60}'),
                      new TextSpan(text: 'h ', style: new TextStyle(fontSize: smallFontSize)),
                      new TextSpan(text: '${currentMovie.runtime - (currentMovie.runtime~/60 ) * 60}'),
                      new TextSpan(text: 'min', style: new TextStyle(fontSize: smallFontSize)),
                    ],
                  ),
                )
              ],
            ),
          )
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

  Widget getImages(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'IMAGES',
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
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: StreamBuilder(
            stream: movieBloc.fetchImages,
            builder: (context, AsyncSnapshot<ImagesModel> imagesSnapshot){
              if(!imagesSnapshot.hasData){
                return Container();
              }
              List<Backdrops> images = imagesSnapshot.data.backdrops;
              return ListView.builder(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index){
                  return AspectRatio(
                    aspectRatio: images[index].aspectRatio,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${images[index].filePath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getVideos(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'VIDEOS',
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
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
//          width: MediaQuery.of(context).size.width * 0.9,
          child: StreamBuilder(
            stream: movieBloc.fetchVideos,
            builder: (context, AsyncSnapshot<VideosModel> videosSnapshot){
              if(!videosSnapshot.hasData){
                return Container();
              }
              List<VideoModel> videos = videosSnapshot.data.results;
              return ListView.builder(
                padding: EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getSimilarMovies(){
    return CollectionOfMoviesWidget(
      title: 'See Also',
      onPressed: null,
      stream: movieBloc.fetchSimilarMovies,
      contentType: ContentType.Movie,
      type: MovieType.Normal,
      backgroundColor: Colors.transparent,
    );
  }

  double modifyRating(double rating){
    return (5 * rating.round()) / 10;
  }
}

