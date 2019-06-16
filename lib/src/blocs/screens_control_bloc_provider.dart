import 'package:flutter/material.dart';
import 'screens_control_bloc.dart';

class ScreensControlProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = ScreensControlBloc();

  ScreensControlProvider({Key key, Widget child})
    : super(key:key, child: child);

  static ScreensControlBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ScreensControlProvider) as ScreensControlProvider).bloc;
  }
}