
import 'package:rxdart/rxdart.dart';

class DiscoverScreenBloc{

  double moviesCurrentPageNum = 0;
  double tvCurrentPageNum = 0;

  final _moviesPageScaleProvider = BehaviorSubject<double>();
  final _moviesPagePositionProvider = BehaviorSubject<double>();
  final _tvPageScaleProvider = BehaviorSubject<double>();
  final _tvPagePositionProvider = BehaviorSubject<double>();

  Observable<double> get getMoviesPageScale => _moviesPageScaleProvider.stream;
  Observable<double> get getMoviesPagePosition => _moviesPagePositionProvider.stream;
  Observable<double> get getTvPageScale => _tvPageScaleProvider.stream;
  Observable<double> get getTvPagePosition => _tvPagePositionProvider.stream;

  Function(double) get pushMoviesScale => _moviesPageScaleProvider.sink.add;
  Function(double) get pushMoviesPagePosition=> _moviesPagePositionProvider.sink.add;
  Function(double) get pushTvScale => _tvPageScaleProvider.sink.add;
  Function(double) get pushTvPagePosition=> _tvPagePositionProvider.sink.add;


  changeMoviesPageNum(double num){
    moviesCurrentPageNum = num;
  }

  changeTvPageNum(double num){
    tvCurrentPageNum = num;
  }

  onDispose(){
    _moviesPageScaleProvider.close();
    _moviesPagePositionProvider.close();
    _tvPageScaleProvider.close();
    _tvPagePositionProvider.close();
  }

}