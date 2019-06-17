import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc_provider.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/utils/types.dart';

class MoviesSeeAllScreen extends StatelessWidget {

  final MovieType movieType;

  MoviesSeeAllScreen( {this.movieType} ) : assert (
    movieType != null
  );

  @override
  Widget build(BuildContext context) {
    final bloc = MoviesScreenBlocProvider.of(context);
    bloc.initSeeAll(movieType);
    return Scaffold(
      body: StreamBuilder<List<MovieModel>>(
        stream: bloc.getAllMovies,
        builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> moviesSnapshot){
          if(!moviesSnapshot.hasData){
            return Container();
          }
          return ListView.builder(
            itemCount: moviesSnapshot.data.length,
            itemBuilder: (context, index){
              int page = (moviesSnapshot.data.length / 20).floor();
              int coeff = 15 + 20*(page-1);
              print('page is $page and coeff is $coeff');
              print('index is $index and remainder is ${index % coeff}');
              if( index % coeff == 0 ){
                if(index > 0){
                  print('page is ${page+1}');
                  if(movieType == MovieType.ComingSoon){
                    bloc.fetchAllComingSoonMoviesByPage(page+1);
                  }else if(movieType == MovieType.TopRated){
                    bloc.fetchAllTopRatedMoviesByPage(page+1);
                  }else{
                    bloc.fetchAllPopularMoviesByPage(page+1);
                  }

                }
              }
              if(index < moviesSnapshot.data.length){
                return ListTile(
                  title: Text(moviesSnapshot.data[index].title),
                  subtitle: Text('$index'),
                );
              }
            }
          );
        },
      ),
    );
  }


}
