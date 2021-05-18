

import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferenceUtil {

      static final String loggedIn = "logged_in";
      static final String loggedOut = "logged_out";
      static final String loadingStatus = "loading";

      static SharedPreferences _sharedPreferences;
      static String  _userStatusKey = "user_status";
      static init() async{
        if(_sharedPreferences == null){
          _sharedPreferences = await SharedPreferences.getInstance();
        }
      }

      static changeUserSessionStatus(String currentStatus) async{
        print("Changing user session status in the shared preference");
        await init();
        _sharedPreferences.setString(_userStatusKey, currentStatus);
      }

      static Future<String> getUserSessionStatus() async{
        print("Getting user session status from the shared preference");
        await init();
       return _sharedPreferences.getString(_userStatusKey) ??loggedOut;
      }

}