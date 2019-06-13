import 'package:flutter/material.dart';
import 'package:movie_looker/src/screens/base_screen.dart';
import 'package:movie_looker/src/screens/celebrities/celebrities_screen.dart';
import 'package:movie_looker/src/screens/discover_screen.dart';

import 'package:movie_looker/src/screens/movies/movies_screen.dart';
import 'package:movie_looker/src/screens/menu_screen.dart';
import 'package:movie_looker/src/screens/hidden_navigator.dart';
import 'package:movie_looker/src/screens/tv_shows/tv_show_screen.dart';
import 'blocs/discover_screen_bloc_provider.dart';
import 'blocs/hidden_navogator_provider.dart';
import 'blocs/movies_screen_bloc_provider.dart';
import 'blocs/screen_navigation_bloc_provider.dart';
import 'blocs/tmdb_api_provider.dart';
import 'blocs/login_provider.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // Example with Scoped Instance
    // most likely used for complex apps with multiple 'bloc' instances
    return LoginProvider(
      child: HiddenNavigatorProvider(
        child: TmdbApiProvider(
          child: DiscoverScreenBlocProvider(
            child: ScreensBlocProvider(
              child: MoviesScreenProvider(
                child: MaterialApp(
                    onGenerateRoute: routes,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Route routes(RouteSettings settings){

    if(settings.name  == '/DISCOVER'){
      return MaterialPageRoute(
        builder: (context){
          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
//          hiddenNavigatorBloc.init();
          return HiddenNavigator(
            menuScreen: MenuScreen(selectedMenu: 0,),
            activeScreen: DiscoverScreen(),
            currentState: hiddenNavigatorBloc.getState(),
            title: 'DISCOVER',
          );
        }
      );
    }else if(settings.name == '/MOVIES'){
      return MaterialPageRoute(
        builder: (context){
          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
//          hiddenNavigatorBloc.init();
          return MoviesScreenProvider(
            child: HiddenNavigator(
              menuScreen: MenuScreen(selectedMenu: 1,),
              activeScreen: MoviesScreen(),
              currentState: hiddenNavigatorBloc.getState(),
              title: 'MOVIES',
            ),
          );
        }
      );

    }else if(settings.name == '/TV_SHOWS'){
      return MaterialPageRoute(
        builder: (context){
          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
//          hiddenNavigatorBloc.init();
          return HiddenNavigator(
            menuScreen: MenuScreen(selectedMenu: 2,),
            activeScreen: TvShowsScreen(),
            currentState: hiddenNavigatorBloc.getState(),
            title: 'TV SHOWS',
          );
        }
      );
    } else if(settings.name == '/CELEBRITIES'){
      return MaterialPageRoute(
        builder: (context){
          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
          hiddenNavigatorBloc.init();
          return HiddenNavigator(
            menuScreen: MenuScreen(selectedMenu: 3,),
            activeScreen: CelebritiesScreen(),
            currentState: hiddenNavigatorBloc.getState(),
            title: 'CELEBRITIES',
          );
        }
      );
    } else if(settings.name == '/SETTINGS'){
      return MaterialPageRoute(
        builder: (context){
          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
          hiddenNavigatorBloc.init();
          return HiddenNavigator(
            menuScreen: MenuScreen(selectedMenu: 4,),
//            activeScreen: settingsScreen,
            currentState: hiddenNavigatorBloc.getState(),
            title: 'SETTINGS',
          );
        }
      );
    } else{
      return MaterialPageRoute(
        builder: (context){
//          final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
//          hiddenNavigatorBloc.init();
//          return HiddenNavigator(
//            menuScreen: MenuScreen(selectedMenu: 0,),
//            activeScreen: DiscoverScreen(),
//            currentState: hiddenNavigatorBloc.getState(),
//            title: 'DISCOVER',
//          );
          return BaseScreen();
        }
      );
    }

  }
}
