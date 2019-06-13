import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: EdgeInsets.all(2.0),


      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
