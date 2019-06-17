import 'package:flutter/material.dart';
import 'movies_screen_bloc.dart';

class MoviesScreenBlocProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = MoviesScreenBloc();

  MoviesScreenBlocProvider({Key key, Widget child})
    : super(key:key, child: child);

  static MoviesScreenBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(MoviesScreenBlocProvider) as MoviesScreenBlocProvider).bloc;
  }
}