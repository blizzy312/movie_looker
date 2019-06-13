//import 'package:flutter/material.dart';
//import '../blocs/login_bloc.dart';
//import '../blocs/login_provider.dart';
//
//class LoginScreen extends StatelessWidget{
//
//  @override
//  Widget build(BuildContext context) {
//    final bloc = Provider.of(context);
//
//    return Container(
//      margin: EdgeInsets.all(20.0),
//      child: Column(
//        children: <Widget>[
//          _emailField(bloc),
//          _passwordField(bloc),
//          _buttonSubmit(bloc)
//        ],
//      )
//    );
//  }
//
//  Widget _emailField(Bloc bloc){
//    return StreamBuilder(
//        stream: bloc.email,
//        builder: (content, snapshot){
//          return TextField(
//            decoration: InputDecoration(
//                hintText: 'you@email.com',
//                labelText: 'email',
//                errorText: snapshot.error
//            ),
//            onChanged: bloc.changeEmail,
//          );
//        }
//    );
//  }
//
//  Widget _passwordField(Bloc bloc){
//    return StreamBuilder(
//      stream: bloc.password,
//      builder: (context, snapshot){
//        return TextField(
//          decoration: InputDecoration(
//              hintText: 'password',
//              labelText: 'password',
//              errorText: snapshot.error
//          ),
//          onChanged: bloc.changePassword,
//        );
//      },
//    );
//  }
//
//  Widget _buttonSubmit(Bloc bloc){
//    return StreamBuilder(
//      stream: bloc.submitValid,
//      builder: (context, snapshot){
//        return RaisedButton(
//          onPressed: snapshot.hasData ? bloc.submit : null  ,
//          child: Text('Submit'),
//        );
//      },
//    );
//
//  }
//}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_looker/src/blocs/hidden_navogator_provider.dart';




class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 1440, height: 2560, allowFontScaling: true)..init(context);
//    final bloc = LoginProvider.of(context);
    final hiddenNavigatorBloc = HiddenNavigatorProvider.of(context);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              width: double.infinity,
              height: ScreenUtil.instance.setHeight(1000),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -10.0),
                    blurRadius: 10.0
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'example@example.com',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                          ),
                          icon: Icon(
                              Icons.account_box,
                          ),
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'example@example.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        icon: Icon(
                          Icons.vpn_key,
                        ),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  RaisedButton(
                      onPressed: (){

                      },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: ScreenUtil.instance.setHeight(200),
          ),
          Text('OR'),
          Container(
            height: ScreenUtil.instance.setHeight(200),
          ),
          RaisedButton(
              onPressed: (){
//                bloc.guestLogin();
                hiddenNavigatorBloc.init();
                Navigator.pushNamed(context, "/MOVIES");
              },
              child: Text('Login as Guest'),
          ),
          Container(
            height: ScreenUtil.instance.setHeight(100),
          ),
        ],
      ),
    );
  }
}

//Container(
//width: double.infinity,
//height: ScreenUtil.instance.setHeight(1100),
//decoration: BoxDecoration(
//color: Colors.blueGrey,
//borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
//),
//padding: EdgeInsets.only(top: 30),
//child: Column(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//Text(
//'Movie',
//style: TextStyle(
//color: Colors.blue,
//fontSize: 50.0,
//fontFamily: 'Blackjack',
//),
//),
//Text(
//'Looker',
//style: TextStyle(
//color: Colors.blue,
//fontSize: 50.0,
//fontFamily: 'Exo',
//),
//),
//],
//),
//),