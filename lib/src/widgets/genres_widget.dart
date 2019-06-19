
import 'package:flutter/material.dart';
import 'package:movie_looker/src/models/genre_model.dart';



class GenresWidgets extends StatelessWidget {
  final List<GenreModel> genres;

  GenresWidgets({this.genres});


  @override
  Widget build(BuildContext context) {
    List<Widget> genreWidgets = [];
    for (GenreModel genre in genres){
      genreWidgets.add(genreView(context, genre.name));
      genreWidgets.add( SizedBox(width: 5,));
    }


    return Container(
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.height * 0.85,

      child: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: genreWidgets,
      ),
    );
  }

  Widget genreView(context, String genreTitle){
    return Container(
//      height: MediaQuery.of(context).size.height * 0.03,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.grey[600]
      ),
      child: Text(
        '${genreTitle.toUpperCase()}',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white
        ),
      ),
    );
  }
}
