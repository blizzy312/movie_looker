import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/tmdb_api_bloc.dart';
import 'package:movie_looker/src/blocs/tmdb_api_provider.dart';
import 'package:movie_looker/src/models/celebrities_model.dart';

import 'package:movie_looker/src/widgets/movie_card.dart';


class CelebritiesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final moviesBloc = TmdbApiProvider.of(context);
    moviesBloc.fetchCelebritiesPage();
    return Scaffold(
      body: Container(
        color: Colors.black54,
        child: ListView(
          children: <Widget>[
            popularCelebrities(context, moviesBloc),
          ],
        ),
      ),
    );
  }

  Widget popularCelebrities(BuildContext context, TmdbApiBloc moviesBloc){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only( left: 25),
                child: Text(
                  "Popular Celebrities",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: (){

              },
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
            ),
          ],
        ),
        StreamBuilder<CelebritiesModel>(
          stream: moviesBloc.mostPopularCelebrities,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container();
            }
            var movies = snapshot.data.results;
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index){
                  return Row(
                    children: <Widget>[
                      index == 0 ? SizedBox(width: 25,) : SizedBox(width: 0),
                      GestureDetector(
                        onTap: (){
//                          moviesBloc.fetchMovieByID(movies[index].id);
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails( movieBloc: moviesBloc)));
                        },
                        child: MovieCard(
                          id: movies[index].id,
                          posterPath: movies[index].profilePath,
                          title: movies[index].name,
                          rating: movies[index].popularity,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  );
                },
              ),
            );
          }
        ),
      ],
    );
  }

}
