import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref{

  static late SharedPreferences _preferences;

  static const _PIN_KEY = "hashedPin";
  static const _registered = "registered";

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUserPin(String hashedPin) async{
    await _preferences.setString(_PIN_KEY, hashedPin);
    print("Setting user pin: "+hashedPin);
  }

  static Future setRegisteredTrue() async{
    await _preferences.setBool(_registered,true);
    print("Setting registered True");
  }

  static Future setRegisteredFalse() async{
    await _preferences.setBool(_registered,false);
    print("Setting registered False ");
  }

  static bool? getRegistered(){
    return _preferences.getBool(_registered);
  }

  static String? getHashedUserPinCode(){
    return _preferences.getString(_PIN_KEY);
  }

}