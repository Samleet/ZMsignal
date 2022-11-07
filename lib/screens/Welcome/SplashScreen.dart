import 'package:ZMstrategy/config/routes/router.dart';
import 'package:ZMstrategy/config/strings/Constants.dart';
import 'package:ZMstrategy/utils/helpers/Storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool splash = false;
  @override
  void initState() {
    initiateApp () ;
    super.initState();
  }

  initiateApp() async {
    bool splash = await Storage.get('welcome',bool) as bool;
    setState(() {
      this.splash = splash;
    });

    if(splash == true){
      RouteGenerator.exit(LOGIN); // redirect to login / app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splash == true ? SizedBox.shrink() : Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          margin: EdgeInsets.only(top: 100, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(height: 20),
              Text("ZMSTRATEGY®", style: TextStyle(
                color: Colors.white,
                fontSize: 20.5,
                fontWeight: FontWeight.bold
              )),
              SizedBox(height: 20),
              Text("Providing trading tools and strategy to help online entrepreneurs and digital marketers to sell and market their products.", style: TextStyle(
                color: Colors.white70,
                fontSize: 16.5,
              ),
                textAlign: TextAlign.center
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
                ),
                clipBehavior: Clip.hardEdge,
                child: ElevatedButton(
                  onPressed: () {
                    Storage.set('welcome', true);
                    RouteGenerator.goto  (LOGIN);
                  },
                  child: Text("Get Started", style: null),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}