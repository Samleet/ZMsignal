import 'package:ZMstrategy/screens/Error/ErrorScreen.dart';
import 'package:ZMstrategy/screens/Layouts/WebViewURI.dart';
import 'package:ZMstrategy/screens/User/LoginScreen.dart';
import 'package:ZMstrategy/screens/Welcome/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:ZMstrategy/config/strings/Constants.dart';

class ScreenProvider {
  static MaterialPageRoute route(String? route, data){

    switch(route){
      case SPLASH:
        return  MaterialPageRoute(builder: (context) => SplashScreen());

      case LOGIN:
        return  MaterialPageRoute(builder: (context) => LoginScreen());

      case WEBVIEW:
        return  MaterialPageRoute(builder: (context) => WebViewScreen(
          url: data['url'],
          title: data['title'],
          cookies: data['cookies'],
          delegates: data['delegates'],
        ));

        

      default:
        return MaterialPageRoute(builder: (context) => ErrorScreen()
        );
    }
  }
}