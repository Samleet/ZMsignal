import 'package:ZMstrategy/config/services/api.dart';
import 'package:ZMstrategy/config/strings/Endpoints.dart';

class LoginController {

  static Future<Map<String, dynamic>> login(Map data) async {
    bool error = false;
    String message ="";
    dynamic response;

    String email = data['email'];
    String password = data['password'];

    if(email.isEmpty){
      error = true;
      message = "You need to enter your Email address";
    }
    else
    if(password.isEmpty){
      error = true;
      message = "You need to enter your Password";
    }
    else{
      var request = await api().post(endpoint(LOGIN_ROUTE), data);   
      if( request != null){
        error = request['status'] != 200 ? true : false;
        message = request['message'];
        response = request;
      }
    }

    return {
      "error": error,
      "message": message,
      "data": response
    };
  }


}