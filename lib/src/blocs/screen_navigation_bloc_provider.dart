import 'package:flutter/material.dart';
import 'screen_navigation_bloc.dart';

class ScreensBlocProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = ScreensBloc();

  ScreensBlocProvider({Key key, Widget child})
    : super(key:key, child: child);

  static ScreensBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ScreensBlocProvider) as ScreensBlocProvider).bloc;
  }
}