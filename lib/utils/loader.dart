import 'package:flutter/material.dart';

enum LoaderType { circular, dialog, text }  // loaders

class Loader extends StatefulWidget {
  static LoaderType loader  = ( LoaderType.circular );
  static void init(arg) => loader = arg;

  @override
  // ignore: no_logic_in_create_state
  State<Loader> createState() => _LoaderState(loader);
}

class _LoaderState extends State<Loader> {
  final loader;
  _LoaderState(LoaderType this.loader);
  
  @override
  Widget build(BuildContext context) {
    if(loader == LoaderType.circular){
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,

          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if(loader == LoaderType.text){
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,

          child: Center(
            child: Text('loading...'), /////////////////
          ),
        ),
      );
    }

    if(loader == LoaderType.dialog){
      return Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.0, offset: Offset(0, 3),
                  color: Colors.grey.withAlpha(30), 
                  blurRadius: 20.0, 
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading...") //////////////////////
              ],
            )
          ),
        ),
      );
    }
    return SizedBox();
  }
}