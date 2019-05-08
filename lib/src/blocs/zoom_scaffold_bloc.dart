import 'package:movie_looker/src/models/zoom_scaffold_animation_model.dart';
import 'package:rxdart/rxdart.dart';

class ZoomScaffoldBloc{
  MenuState currentState;

  final _stateController = BehaviorSubject<MenuState>();
  final _animationController = BehaviorSubject<ZoomScaffoldAnimationModel>();



  ZoomScaffoldBloc(){
    _stateController.stream.transform(stateTransformer()).pipe(_animationController);
  }

  Observable<ZoomScaffoldAnimationModel> get animationValues => _animationController.stream;

  stateTransformer(){
    return FlatMapStreamTransformer<MenuState, ZoomScaffoldAnimationModel>(
        (state){
          var animationNumbers = ZoomScaffoldAnimationModel();
          final streamX = BehaviorSubject<ZoomScaffoldAnimationModel>();
          switch (state){
            case MenuState.open:
              animationNumbers.slideAmount = 275.0 ;
              animationNumbers.contentScale = 1.0 - 0.2;
              animationNumbers.cornerRadius = 10.0;
              break;

            case MenuState.closed:
              animationNumbers.slideAmount = 0.0 ;
              animationNumbers.contentScale = 1.0;
              animationNumbers.cornerRadius = 0.0;
              break;

            case MenuState.opening:
              break;

            case MenuState.closing:
              break;
          }
          streamX.sink.add(animationNumbers);
          return streamX;
        }
    );
  }

  init(){
    currentState = MenuState.closed;
    _stateController.sink.add(currentState);
  }

  toggleState(){
    switch(currentState){
      case MenuState.open:
        currentState = MenuState.closed;
        break;

      case MenuState.closed:
        currentState = MenuState.open;
        break;

      case MenuState.opening:
        break;

      case MenuState.closing:
        break;
    }

    _stateController.sink.add(currentState);
  }

  onDispose(){
    _stateController.close();
    _animationController.close();
  }
}




enum MenuState{
  open,
  closed,
  opening,
  closing
}