import 'package:flutter/material.dart';

class DiscoverMovieCard extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final num voteNum;
  final String posterPath;
  final double imageScale;

  DiscoverMovieCard({this.id,this.title, this.overview, this.voteNum, this.posterPath, this.imageScale});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width * 0.65,
      margin: EdgeInsets.all(2.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(115, 115, 115, 1),
                  offset: Offset(0.0, 30.0),
                  blurRadius: 20.0
                ),
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Transform.scale(
                scale: imageScale,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500$posterPath',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
