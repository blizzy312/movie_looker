import 'package:flutter/material.dart';
import 'tmdb_api_bloc.dart';

class TmdbApiProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = TmdbApiBloc();

  TmdbApiProvider({Key key, Widget child})
      : super(key:key, child: child);

  static TmdbApiBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(TmdbApiProvider) as TmdbApiProvider).bloc;
  }
}