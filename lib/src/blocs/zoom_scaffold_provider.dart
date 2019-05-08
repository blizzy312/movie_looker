import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/zoom_scaffold_bloc.dart';


class ZoomScaffoldProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = ZoomScaffoldBloc();

  ZoomScaffoldProvider({Key key, Widget child})
      : super(key:key, child: child);

  static ZoomScaffoldBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ZoomScaffoldProvider) as ZoomScaffoldProvider).bloc;
  }
}