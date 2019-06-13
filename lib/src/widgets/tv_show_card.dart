import 'package:flutter/material.dart';

class TvShowCard extends StatelessWidget {
  final int id;
  final String title;
  final num rating;
  final String posterPath;



  TvShowCard({this.id,this.title, this.rating, this.posterPath});

  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$posterPath',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Color(0xFF6387A6),
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
                      )
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
}
