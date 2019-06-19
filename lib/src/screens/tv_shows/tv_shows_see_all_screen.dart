import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/tv_shows_screen_bloc_provider.dart';
import 'package:movie_looker/src/models/discover_tv_shows_model.dart';
import 'package:movie_looker/src/utils/types.dart';

class TvShowsSeeAllScreen extends StatelessWidget {

  final TvShowType tvShowType;

  TvShowsSeeAllScreen( {this.tvShowType} ) : assert (
  tvShowType != null
  );

  @override
  Widget build(BuildContext context) {
    final bloc = TvShowsScreenBlocProvider.of(context);
    bloc.initSeeAll(tvShowType);
    return Scaffold(
      body: StreamBuilder<List<TvShowModel>>(
        stream: bloc.getAllTvShows,
        builder: (BuildContext context, AsyncSnapshot<List<TvShowModel>> tvShowsSnapshot){
          if(!tvShowsSnapshot.hasData){
            return Container();
          }
          return ListView.builder(
            itemCount: tvShowsSnapshot.data.length,
            itemBuilder: (context, index){
              int currentPage = (tvShowsSnapshot.data.length / 20).floor();
              int indexLimit = 15 + 20*(currentPage-1);
              if( index % indexLimit == 0 ){
                if(index > 0){
                  if(tvShowType == TvShowType.TopRated){
                    bloc.fetchAllTopRatedTvShowsByPage(currentPage+1);
                  }else{
                    bloc.fetchAllPopularTvShowsByPage(currentPage+1);
                  }
                }
              }
              if(index < tvShowsSnapshot.data.length){
                return ListTile(
                  title: Text(tvShowsSnapshot.data[index].name),
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
