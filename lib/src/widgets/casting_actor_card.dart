import 'package:flutter/material.dart';
import 'package:movie_looker/src/models/cast_model.dart';



class CastingActorCard extends StatelessWidget {
  final Cast actor;

  CastingActorCard({this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 5.0,
                  blurRadius: 5
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.30,
              ),
            ),
          ),
          SizedBox(height: 25,),
          Text(
            '${actor.name}',
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,

            ),
          ),
          Text(
            '${actor.character}',
            softWrap: true,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey
            ),
          )
        ],
      ),
    );
  }
}
