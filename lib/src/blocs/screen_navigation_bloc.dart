import 'package:movie_looker/src/screens/celebrities/celebrities_screen.dart';
import 'package:movie_looker/src/screens/home_screen.dart';
import 'package:movie_looker/src/screens/movies/movies_screen.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ScreensBloc{
//  final _currentScreenProvider = BehaviorSubject<Widget>();
  final _navigationListener = BehaviorSubject<int>();

//  ScreensBloc(){
//    _navigationListener.listen((ind) {
//      print('inside of bloc $ind');
//      Widget temp;
//      switch (ind) {
//
//        case  0:
//          temp = HomeScreen();
////          _currentScreenProvider.sink.add(HomeScreen());
//          break;
//        case  1:
//          temp = MoviesScreen();
////          _currentScreenProvider.sink.add(MoviesScreen());
//          break;
//        case  2:
//          temp = TvShowsScreen();
////          _currentScreenProvider.sink.add(TvShowsScreen());
//          break;
//        case  3:
//          temp = CelebritiesScreen();
////          _currentScreenProvider.sink.add(CelebritiesScreen());
//          break;
//        default:
//          temp = HomeScreen();
////          _currentScreenProvider.sink.add(HomeScreen());
//          break;
//      }
//      print('temp is $temp');
//      _currentScreenProvider.sink.add(temp);
//    });
//  }
//
//  Observable<Widget> get fetchCurrentScreen => _currentScreenProvider.stream;

  Observable<int> get fetchNavigationIndex => _navigationListener.stream;

  Function(int) get pushNavigationIndex => _navigationListener.sink.add;

//  pushNavigationIndex(int ind){
//    _navigationListener.sink.add(ind);
//  }

  int fetchIndex () => _navigationListener.value;
//  Function(int) get pushNavigationIndex => _navigationListener.sink.add;
//  pushNavigationIndex(int ind){
//    _navigationListener.sink.add(ind);
//  }

  dispose(){
//    _currentScreenProvider.close();
    _navigationListener.close();
  }
}