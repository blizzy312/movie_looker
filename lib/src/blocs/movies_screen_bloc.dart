import 'package:rxdart/rxdart.dart';

class MoviesScreenBloc {

  double moviesCurrentPageNum = 0;

  final _imageProvider = PublishSubject<String>();

  final _moviesPageScaleProvider = BehaviorSubject<double>();
  final _moviesPagePositionProvider = PublishSubject<double>();

  Observable<String> get getBackgroundImage => _imageProvider.stream;

  Observable<double> get getMoviesPageScale => _moviesPageScaleProvider.stream;
  Observable<double> get getMoviesPagePosition => _moviesPagePositionProvider.stream;


  Function(double) get pushMoviesScale => _moviesPageScaleProvider.sink.add;
  Function(double) get pushMoviesPagePosition=> _moviesPagePositionProvider.sink.add;

  Function(String) get setBackgroundImage => _imageProvider.sink.add;

  changeMoviesPageNum(double num){
    moviesCurrentPageNum = num;
  }

  dispose(){
    _imageProvider.close();
    _moviesPageScaleProvider.close();
    _moviesPagePositionProvider.close();
  }
}