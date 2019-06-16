import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_looker/src/widgets/collection_of_movies.dart';

class MovieCard extends StatelessWidget {
  final int id;
  final String title;
  final num rating;
  final String posterPath;
  final String releaseDate;
  final MovieType type;

  MovieCard({this.id,this.title, this.rating, this.posterPath, this.releaseDate, this.type});

  @override
  Widget build(BuildContext context) {
    print(releaseDate);
    return Container(

      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: EdgeInsets.all(2.0),


      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Hero(
                tag: id,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w300$posterPath',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[700],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      type == MovieType.Normal ?
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 17,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$rating',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ) : Container(
                        width: double.infinity,
                        child: Text(
                          '${changeDate(releaseDate)}',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String changeDate(String date){
    if(date != null){
      DateTime myDatetime = DateTime.parse("$date");
      String x = new DateFormat("MMM d").format(myDatetime).toString();
      return x;
    }
    return "";
  }

}
