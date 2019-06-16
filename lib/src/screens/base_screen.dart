import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/screen_navigation_bloc_provider.dart';
import 'package:movie_looker/src/screens/celebrities/celebrities_screen.dart';
import 'package:movie_looker/src/screens/movies/movies_screen.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_screen.dart';
import 'package:movie_looker/src/widgets/bottom_nav_bar/fab_bottom_app_bar.dart';

import 'package:movie_looker/src/widgets/bottom_nav_bar/layout.dart';

import 'home_screen.dart';

class BaseScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final navigationBloc = ScreensBlocProvider.of(context);
    return StreamBuilder<int>(
      initialData: 0,
      stream: navigationBloc.fetchNavigationIndex,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        Widget screen ;

        switch (snapshot.data){
          case 0:
            screen = HomeScreen();
            break;
          case 1:
            screen = MoviesScreen();
            break;
          case 2:
            screen = TvShowsScreen();
            break;
          case 3:
            screen = CelebritiesScreen();
            break;
        }
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: FABBottomAppBar(
            centerItemText: 'Search',
            color: Colors.white,
            selectedColor: Colors.yellow,
            notchedShape: CircularNotchedRectangle(),

            onTabSelected: (ind) {
              navigationBloc.pushNavigationIndex(ind);
            },
            backgroundColor: Color(0xFF3A3940),
            items: [
              FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
              FABBottomAppBarItem(iconData: Icons.movie, text: 'Movies'),
              FABBottomAppBarItem(iconData: Icons.live_tv, text: 'Tv Shows'),
              FABBottomAppBarItem(iconData: Icons.people_outline, text: 'Celebs'),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(
            context),
          body: screen,
        );
      }
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//          child: FabWithIcons(
//            icons: icons,
//            onIconTapped: _selectedFab,
//          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          print('fab clicked');
        },
        child: Icon(Icons.search),
        elevation: 2.0,
        backgroundColor: Colors.grey[700],
      ),
    );
  }

}
