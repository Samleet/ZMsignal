import 'package:flutter/material.dart';
import 'package:ZMstrategy/utils/colors.dart';

class Stylesheet {
  static ThemeData lightTheme() {

    return ThemeData(
        /*
        * Define the primary color and brightness level for current theme
        */
        // colorSchemeSeed: (Color(0XFF343674) ),
        colorSchemeSeed: (Color(0XFF4951ac)),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        // primarySwatch: Colors.deepPurple,
        // primaryColor: HexColor('#182551'),

        /*
        * Define the font family to be used across the wholw application
        */
        fontFamily: 'Poppings',

        /*
        * Define the default `appTheme`. Use this to specify the default
        * text styling for headlines, titles, bodies of text, and more.
        */
        appBarTheme: AppBarTheme  (
          elevation: 0,
          centerTitle: true,
          // color: HexColor('#305acb'),
          iconTheme: IconThemeData(
            color: HexColor('#4951ac')
          ),

          titleTextStyle: TextStyle(
            fontSize: 18,
            color: HexColor('#4951ac')
          ),
          backgroundColor: Colors.transparent,

          /*
          iconTheme: IconThemeData(
            color: Colors.white
          ),

          titleTextStyle: TextStyle(
            color: Colors.white
          ),
          backgroundColor: Color   (0xFF343674),
          */
        ),

        /*
        * Define the default tex buttonThemeData:`. Use this to specify 
        * the default styling for flutter buttons: i.e [T,E,O] elements
        */
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: HexColor('#4951ac')
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('#4951ac')
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: HexColor('#4951ac')
          ),
        ),

        /*
        * Define the default`TextTheme`. Use this to setup the default
        * text styling for headlines, titles, bodies of text, and more.
        */
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0, 
            fontWeight: FontWeight.bold
            ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),

        /*
        * Define the default `NavigationBarTheme:`. Use this to specify 
        * the default styling for navigationbar and selected menu items 
        */
        //Bottom Navigation
        navigationBarTheme: NavigationBarThemeData(
          height: 60,
          backgroundColor: Colors.white,
          indicatorColor: Color(0XFFf1f5fb),
          iconTheme: MaterialStateProperty.all(
            IconThemeData(
              color: HexColor('#4951ac'),
            ),
          ),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Averta',
            )
          )
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: HexColor('#4951ac'),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: Colors.red),
        )
    );
  }
  
}