import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {

  final String title;
  final bool isSelected;

  MenuItem( {this.title, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: isSelected ? null : () {
        print('$title is tapped');
        Navigator.pushNamed(context, '/$title');
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, top:  15.0, bottom: 15.0),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 25.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
