import 'package:flutter/material.dart';

import 'discover_screen_bloc.dart';



class DiscoverScreenBlocProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = DiscoverScreenBloc();

  DiscoverScreenBlocProvider({Key key, Widget child})
    : super(key:key, child: child);

  static DiscoverScreenBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(DiscoverScreenBlocProvider) as DiscoverScreenBlocProvider).bloc;
  }
}