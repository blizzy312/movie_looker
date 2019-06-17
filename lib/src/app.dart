import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/movies_screen_bloc_provider.dart';
import 'package:movie_looker/src/screens/base_screen.dart';

import 'blocs/screens_control_bloc_provider.dart';
import 'blocs/screen_navigation_bloc_provider.dart';
import 'blocs/tmdb_api_provider.dart';
import 'blocs/login_provider.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // Example with Scoped Instance
    // most likely used for complex apps with multiple 'bloc' instances
    return LoginProvider(
      child: TmdbApiProvider(
        child: ScreensBlocProvider(
          child: ScreensControlProvider(
            child: MoviesScreenBlocProvider(
              child: MaterialApp(
                onGenerateRoute: routes,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Route routes(RouteSettings settings){

    return MaterialPageRoute(
      builder: (context){
        return BaseScreen();
      }
    );

  }
}
