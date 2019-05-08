import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_looker/src/screens/zoom_scaffold.dart';

final Screen settingsScreen = new Screen(
    title: 'Settings',
    contentBuilder: (BuildContext context) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 10.0,
              color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil.instance.setHeight(500),
                    width: double.infinity,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
