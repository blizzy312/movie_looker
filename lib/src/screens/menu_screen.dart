import 'package:flutter/material.dart';
import 'package:movie_looker/src/widgets/menu_items.dart';

class MenuScreen extends StatelessWidget {
  final int selectedMenu;

  MenuScreen({this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Stack(
          children: <Widget>[
            createMenuTitle(),
            createMenuItems(),
          ],
        ),
      ),
    );
  }

  createMenuTitle(){
    return Transform(
      transform: Matrix4.translationValues(
        -100.0,
        0.0,
        0.0,
      ),
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Color(0x88444444),
              fontSize: 240.0,
            ),
            textAlign: TextAlign.left,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  createMenuItems(){
    return Transform(
      transform: new Matrix4.translationValues(
        0.0,
        225.0,
        0.0,
      ),
      child: Column(
        children: <Widget>[
          MenuItem(
            title: 'Movies', isSelected: selectedMenu == 0 ? true : false,
          ),
          MenuItem(
            title: 'menu2', isSelected: selectedMenu == 1? true : false,
          ),
          MenuItem(
            title: 'menu3', isSelected: selectedMenu == 2 ? true : false,
          ),
          MenuItem(
            title: 'Settings', isSelected: selectedMenu == 3 ? true : false,
          ),
        ],
      ),
    );
  }
}


