import 'package:flutter/material.dart';
import 'package:movie_looker/src/blocs/zoom_scaffold_provider.dart';
import 'package:movie_looker/src/screens/main_screen.dart';
import 'package:movie_looker/src/screens/menu_screen.dart';
import 'package:movie_looker/src/screens/settings_screen.dart';
import 'package:movie_looker/src/screens/zoom_scaffold.dart';
import 'screens/login_screen.dart';
import 'blocs/login_provider.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // Example with Scoped Instance
    // most likely used for complex apps with multiple 'bloc' instances
    return LoginProvider(
      child: ZoomScaffoldProvider(
        child: MaterialApp(
            title: 'Login Block',
            onGenerateRoute: routes,
        ),
      ),
    );
  }
  Route routes(RouteSettings settings){
    if(settings.name  == '/'){
      return MaterialPageRoute(
          builder: (context){
            return LoginScreen();
          }
      );
    }else if(settings.name == '/Movies'){
      return MaterialPageRoute(
        builder: (context){
          final bloc = ZoomScaffoldProvider.of(context);
          bloc.init();
          return ZoomScaffold(
            menuScreen: MenuScreen(selectedMenu: 0,),
            activeScreen: mainScreen,
          );
        }
      );
    }else if(settings.name == '/Settings'){
      return MaterialPageRoute(
        builder: (context){
          final bloc = ZoomScaffoldProvider.of(context);
          bloc.init();
          return ZoomScaffold(
            menuScreen: MenuScreen(selectedMenu: 3,),
            activeScreen: settingsScreen,
          );
        }
      );
    }

    return null;

  }
}
