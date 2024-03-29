import 'package:ZMstrategy/config/strings/Constants.dart';
import 'package:ZMstrategy/config/routes/router.dart';
import 'package:ZMstrategy/widget/MessagingWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ZMstrategy/config/themes/Stylesheet.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

// void main() => runApp(const MyApp());
Future<void> firebaseMessagingHandler(message) async {
  await Firebase.initializeApp();
  print("Handling a FCM Background Message ${ message.messageId }");
  MessagingWidget.showNotification(message);
}

Future main() async {
  //configure device & system properties
  WidgetsBinding widget = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widget
  );

  await Firebase.initializeApp();

  //ensure device is init on "portraits"
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ])
  .then((_) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
    MessagingWidget.initialize();

    runApp(const MyApp());
    /*
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: const MyApp()
      )
    );
    */
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){

    super.initState();
    Timer(Duration(milliseconds: 1000),() => FlutterNativeSplash.remove());
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZMstrategy',
      theme: Stylesheet.lightTheme(),
      initialRoute: SPLASH,
      navigatorKey: navigator,
      onGenerateRoute: RouteGenerator.init,
      builder: (context, child) {
        final scaleSize = MediaQuery.of(context).textScaleFactor.clamp    (
          0.5, 1.0
        );

        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: scaleSize),
        );
        
      },
    );
  }
}