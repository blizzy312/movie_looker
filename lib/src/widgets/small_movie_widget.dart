import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc_provider.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/screens/movies/movie_details_screen.dart';
import 'package:movie_looker/src/screens/movies/upcoming_movie_details_screen.dart';
import 'package:movie_looker/src/utils/types.dart';

import 'package:intl/intl.dart';

class SmallMovieWidget extends StatelessWidget {

  final movieGenresList = [
  {"id": 28, "name": "Action"},
  {"id": 12, "name": "Adventure"},
  {"id": 16, "name": "Animation"},
  {"id": 35, "name": "Comedy"},
  {"id": 80, "name": "Crime"},
  {"id": 99, "name": "Documentary"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Family"},
  {"id": 14, "name": "Fantasy"},
  {"id": 36, "name": "History"},
  {"id": 27, "name": "Horror"},
  {"id": 10402, "name": "Music"},
  {"id": 9648, "name": "Mystery"},
  {"id": 10749, "name": "Romance"},
  {"id": 878, "name": "Science Fiction"},
  {"id": 10770, "name": "TV Movie"},
  {"id": 53, "name": "Thriller"},
  {"id": 10752, "name": "War"},
  {"id": 37, "name": "Western"}
  ];

  final int id;
  final String posterPath;
  final String movieTitle;
  final num rating;
  final List<int> genres;
//  final ContentType contentType;
  final MovieType movieType;
  final String releaseDate;
//  final TvShowType tvShowType;

  SmallMovieWidget({
    this.id,
//    this.contentType,
    this.movieType,
//    this.tvShowType,
    this.posterPath,
    this.movieTitle,
    this.rating,
    this.genres,
    this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    final moviesScreenBloc = MoviesScreenBlocProvider.of(context);
    moviesScreenBloc.pushGenreIds(genres);
    final moviesBloc = TmdbApiProvider.of(context);
    return GestureDetector(
      onTap: (){
        moviesBloc.fetchMovieByID(id);
        Navigator.push(context, MaterialPageRoute(
          builder: (context)
          => movieType == MovieType.ComingSoon ? UpcomingMovieDetails( movieBloc: moviesBloc)
            : MovieDetails(movieBloc: moviesBloc,),
        ));

      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        color: Color(0xFF141A32),
        padding: EdgeInsets.all(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF1E2747),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '$movieTitle',
                                style: TextStyle(
                                  color: Color(0xFFC6CBD9),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: movieType == MovieType.ComingSoon
                                ? Text(
                                changeDate(releaseDate),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFC6CBD9),
                                  fontWeight: FontWeight.bold
                                ),
                              )
                                : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FlutterRatingBarIndicator(
                                    itemSize: 15,
                                    rating: modifyRating(rating),
                                    emptyColor: Color(0x65FFFFFF),
                                    fillColor: Color(0xFFFFD200),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    '$rating',
                                    style: TextStyle(
                                      color: Color(0xFFFFD700),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 35,),
                            Expanded(child: getGenresTitles(moviesScreenBloc, genres)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              )
            ),
            Positioned(
              top: 0,
              bottom: 20,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w300$posterPath',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double modifyRating(num rating){
    return (5 * rating.round()) / 10;
  }

  String changeDate(String date){
    DateTime myDatetime = DateTime.parse("$date");
    String x = new DateFormat("MMM d").format(myDatetime).toString();
    return x;
  }

  Widget getGenresTitles(MoviesScreenBloc moviesScreenBloc,List<int> genreIds){
    print(genreIds);
    List<Widget> list = [];
    for(int genreId in genreIds){
      for(var genre in movieGenresList){
        if(genre.containsValue(genreId)){
          list.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            child: Text(
              genre['name'],
              style: TextStyle(
                color: Color(0xFFC6CBD9),
                fontSize: 15,
              ),
            ),
          ));
          list.add(VerticalDivider(
            color: Color(0xFFFFD700),
            width: 10,
          ));
        }
      }
    }
    list.removeLast();
    return ListView(
      shrinkWrap: false,
      scrollDirection: Axis.horizontal,
      children: list
    );
//    return StreamBuilder(
//      stream: moviesScreenBloc.getGenreNames,
//      builder: (context, AsyncSnapshot<List<GenreModel>> genreTitlesSnapshot){
//        if(!genreTitlesSnapshot.hasData){
//          return Container();
//        }
//        List<Widget> list = [];
//        for(int genreId in genres){
//          genresList.map( (k) {
//            if(k.containsValue(genreId)){
//              print(k.values);
//            }
//          });
//        }
//        return Row(
//          children: list
//        );
////        return GenresWidgets(genres: genreTitlesSnapshot.data,);
////        return new ListView(
////          shrinkWrap: false,
////          scrollDirection: Axis.horizontal,
////          children: genreTitlesSnapshot.data.map((item)
////          => new Text(
////            item,
////            style: TextStyle(
////              color: Color(0xFFC6CBD9),
////              fontSize: 15
////            ),
////          )).toList());
//      },
//    );
  }

}
