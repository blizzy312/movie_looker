import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc_provider.dart';
import 'package:movie_looker/src/models/movie_model.dart';
import 'package:movie_looker/src/utils/types.dart';
import 'package:movie_looker/src/widgets/small_movie_widget.dart';

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
      body: Container(
        color: Color(0xFF141A32),
        child: StreamBuilder<List<MovieModel>>(
          stream: bloc.getAllMovies,
          builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> moviesSnapshot){
            if(!moviesSnapshot.hasData){
              return Container();
            }
            return ListView.builder(
              shrinkWrap: false,
              itemCount: moviesSnapshot.data.length,
              itemBuilder: (context, index){
                int currentPage = (moviesSnapshot.data.length / 20).floor();
                int indexLimit = 15 + 20*(currentPage-1);
                if( index % indexLimit == 0 ){
                  if(index > 0){
                    if(movieType == MovieType.ComingSoon){
                      bloc.fetchAllComingSoonMoviesByPage(currentPage+1);
                    }else if(movieType == MovieType.TopRated){
                      bloc.fetchAllTopRatedMoviesByPage(currentPage+1);
                    }else{
                      bloc.fetchAllPopularMoviesByPage(currentPage+1);
                    }
                  }
                }

                return SmallMovieWidget(
                  id: moviesSnapshot.data[index].id,
                  posterPath: moviesSnapshot.data[index].posterPath,
                  movieTitle: moviesSnapshot.data[index].title,
                  genres: moviesSnapshot.data[index].genreIds,
                  releaseDate: moviesSnapshot.data[index].releaseDate,
                  movieType: movieType,
                  rating: moviesSnapshot.data[index].voteAverage,
                );

              }
            );
          },
        ),
      ),
    );
  }


}
