import 'dart:async';
import 'dart:convert';
import 'package:ZMstrategy/config/routes/router.dart';
import 'package:ZMstrategy/config/services/controllers/LoginController.dart';
import 'package:ZMstrategy/config/strings/Constants.dart';
import 'package:ZMstrategy/screens/Layouts/TextInput.dart';
import 'package:ZMstrategy/utils/helpers/Storage.dart';
import 'package:ZMstrategy/utils/toaster.dart';
import 'package:ZMstrategy/widget/MessagingWidget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  Map user = {};
  int countdown = 5;
  late Timer _timer;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // email.text = 'smithjohn@gmail.com';
    // password.text = 'smith.com';

    getLoggedInUser();

    super.initState();
  }

  void redirect(String token){
    RouteGenerator.goto(WEBVIEW, {
      "url": "https://beta.zmstrategy.com?token=$token&channel=app",
      "delegates": {
        "signout": () {
          Storage.delete('user');
          RouteGenerator.exit(LOGIN);
        }
      }
    });
  }

  Future getLoggedInUser() async {
    var getSession = await Storage.get('user', String).then((value) {
      if(value.runtimeType == String && value.isNotEmpty){

        var me = jsonDecode(value);
        setState(() => user = me );

        _timer = Timer.periodic(Duration(seconds: 1), (timer) async { 
          setState(() {
            countdown = countdown > 1 ? countdown - 1 : 0;
          });

          if(countdown == 0){
            if(!await isOnline()){
              Toaster.info("No Internet Connection, retrying ... ");

              setState(() {
                countdown = 5;
              });

              return;
            }

            _timer.cancel();

            RouteGenerator.goBack();

            redirect(
              user['access_token']
            );           
          }
        });
      }
      
    });
  }

  Future<dynamic> login () async {
    Map data = {
      "email": email.text,
      "password": password.text,
    };

    setState(() {
      isLoading = true;
    });

    var login = await LoginController.login(data).then((response) 
    async {
      setState(() {
        isLoading = false;
      });

      if (response['error']){
          Toaster.show(
            message: response['message'],
            status: "error",
            position: 'SNACKBAR'
          );
          return 0;
      }
      else{
        var user = response['data']['user'];

        Toaster.show(
          message: "Welcome back to ZMstrategy ${user['fullname']}",
          status: "success",
          position: 'TOP'
        );
        
        var api = Storage.set('user', user);
        
        //Subscribe to Signals
        user['signals'].forEach((signal) {
          var subscription = MessagingWidget.subscribe(
            signal
          );
        });
          
        redirect(user['access_token']); //pushing the final redirect
      }
    });
  }

  Future<bool> isOnline () async {
    bool connection = await InternetConnectionChecker().hasConnection;

    return connection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 120),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if(user.isNotEmpty)
                ...[
                  Center(
                    child: Image(
                        image: AssetImage('assets/images/point.png'),
                        width: 200,
                        height: 200,
                      ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Welcome Back, ${user['firstname']}!", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Hang on!, we're currently redirecting you to your account", style: TextStyle(
                    fontSize: 16,
                  ),textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(countdown.toString(), style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      _timer.cancel();
                      Storage.delete('user');
                      user = {};
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Logout", style: TextStyle(
                        fontSize: 15,
                        color: Color(0XFF094163)
                        // fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ]
                else ...[
                  Center(
                    child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 200,
                        height: 200,
                      ),
                  ),
                  Text("Login to your account to access your sales, services, signals and more.", style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center),
                  SizedBox(height: 40),
                  TextInput(
                    label: "E-mail", 
                    icon: Icons.email,
                    type: TextInputType.text, 
                    controller: email,
                  ),
                  TextInput(
                    label: "Password", 
                    icon: Icons.password,
                    type: TextInputType.text, 
                    controller: password,
                    password: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => login(),
                            style: ElevatedButton.styleFrom(shape: StadiumBorder()), //new button
                            child: isLoading ?  
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            )
                            :
                            Text("Log in")
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () { 
                            RouteGenerator.goto(WEBVIEW, {
                              "url": 'https://beta.zmstrategy.com/account/register', 
                            });
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "New user? ",
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,
                              fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Create an account",
                                  style: TextStyle(
                                    color: Color(0XFF094163)
                                  ),
                                  // recognizer: TapGestureRecognizer()..onTap = () => print('Tap'),
                                ),
                              ]
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}