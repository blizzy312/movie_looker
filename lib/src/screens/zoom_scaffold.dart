import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_looker/src/blocs/zoom_scaffold_bloc.dart';
import 'package:movie_looker/src/blocs/zoom_scaffold_provider.dart';
import 'package:movie_looker/src/models/zoom_scaffold_animation_model.dart';

class ZoomScaffold extends StatefulWidget {

  final Widget menuScreen;
  final Screen activeScreen;


  ZoomScaffold({
    this.menuScreen,
    this.activeScreen
  });

  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {

  Animation<double> slideAnimation;
  AnimationController slideAnimationController;
  Animation<double> scaleAnimation;
  AnimationController scaleAnimationController;
  Animation<double> borderAnimation;
  AnimationController borderAnimationController;

  @override
  void initState() {
    super.initState();

    slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    slideAnimation = Tween(begin: 0.0, end: 275.0)
        .animate(
      CurvedAnimation(
          parent: slideAnimationController,
          curve: Curves.easeIn),
    );

    scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    scaleAnimation = Tween(begin: 1, end: 0.8)
        .animate(
      CurvedAnimation(
          parent: scaleAnimationController,
          curve: Curves.easeIn),
    );
    borderAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    borderAnimation = Tween(begin: 0.0, end: 10.0)
        .animate(
      CurvedAnimation(
          parent: borderAnimationController,
          curve: Curves.easeIn),
    );

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 1440, height: 2560, allowFontScaling: true)..init(context);

    return Stack(
        children: [
          widget.menuScreen,
          createContentDisplay(context)
        ]
    );
  }

  createContentDisplay(context){
    final bloc = ZoomScaffoldProvider.of(context);
    return  zoomAndSlideContext(
        bloc,
        Container(
          color: Colors.cyan,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                widget.activeScreen.title,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (){
                    bloc.toggleState();
                  }
              ),
            ),
            body: widget.activeScreen.contentBuilder(context),

          ),
        )
    );
  }

  zoomAndSlideContext(ZoomScaffoldBloc bloc, Widget content){
    print('generated');
    return StreamBuilder<Object>(
      initialData: new ZoomScaffoldAnimationModel(),
      stream: bloc.animationValues,
      builder: (context, snapshot) {
        ZoomScaffoldAnimationModel values = snapshot.data;
        return Transform(
          transform: Matrix4
            .translationValues(values.slideAmount, 0.0, 0.0)
            ..scale(values.contentScale,values.contentScale),
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 20.0,
                  spreadRadius: 10.0,
                )
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(values.cornerRadius),
                child: content
            ),
          ),
        );
      }
    );
  }
}

class Screen{
  final String title;
  final WidgetBuilder contentBuilder;

  Screen({
    this.title,
    this.contentBuilder,
  });
}