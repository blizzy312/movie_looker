import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:movie_looker/src/blocs/screen_navigation_bloc_provider.dart';

import 'home_screen.dart';

class BaseScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    int ind = 0;
    final navigationBloc = ScreensBlocProvider.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(

        currentIndex: ind,
        backgroundColor: Color(0xFF26252C),
        onItemSelected: (index) {
          navigationBloc.pushNavigationIndex(index);
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.yellow,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.movie),
            title: Text('Movies'),
            activeColor: Colors.yellow,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.live_tv),
            title: Text('Tv Shows'),
            activeColor: Colors.yellow,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Celebs'),
            activeColor: Colors.yellow,
            inactiveColor: Colors.white,
          ),
        ],
      ),
      body: StreamBuilder<Widget>(
        stream: navigationBloc.fetchCurrentScreen,
        builder: (context, AsyncSnapshot<Widget> snapshot){
          if(!snapshot.hasData){
            return HomeScreen();
          }
          return snapshot.data;
        }
      ),
    );
  }
}
