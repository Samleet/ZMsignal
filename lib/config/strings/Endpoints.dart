/*
String endpoint(String url, [
  String status = "", String env = 'TEST']){ //////////////

  if(env == 'TEST'){
    return (TEST_URL + url);
  }
  return (LIVE_URL + url);
}
*/

String endpoint(String url, [
  String status = "", String env = 'LIVE']){ //////////////
  Map<String, dynamic> api = {
    "TEST": "https://10.0.2.2:8000/api",
    "LIVE": "https://beta.zmstrategy.com/api"
  };

  return api[env] + url;

}

//AUTH
const LOGIN_ROUTE = '/account/login';

///////////////////////////////////////////////////////////