import 'package:flutter/material.dart';
import 'movies_screen_bloc.dart';

class MoviesScreenProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = MoviesScreenBloc();

  MoviesScreenProvider({Key key, Widget child})
    : super(key:key, child: child);

  static MoviesScreenBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(MoviesScreenProvider) as MoviesScreenProvider).bloc;
  }
}