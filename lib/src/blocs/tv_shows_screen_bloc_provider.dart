import 'package:flutter/material.dart';
import 'tv_shows_screen_bloc.dart';

class TvShowsScreenBlocProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = TvShowsScreenBloc();

  TvShowsScreenBlocProvider({Key key, Widget child})
    : super(key:key, child: child);

  static TvShowsScreenBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(TvShowsScreenBlocProvider) as TvShowsScreenBlocProvider).bloc;
  }
}