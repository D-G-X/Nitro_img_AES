import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static const _keyCounter = 'counter';
  static const _keyListImageFiles = 'encryptedImageFiles';
  static const _hasedPin = "hashedPin";
  static const _registered = "registered";

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
    // _preferences.setBool(_registered, false);
    print("Initialized");
  }
  
  static Future setCounter(int counter) async{
    print("Setting the counter Refresh value");
    await _preferences.setInt(_keyCounter, counter);
    print("counterRefresh value was saved.");
  }

  static Future setEncryptedImageFiles(List<String> encryptedImageFiles) async {
    await _preferences.setStringList(_keyListImageFiles, encryptedImageFiles);
  }

  static List<String>? getEncryptedImageFiles(){
    return _preferences.getStringList(_keyListImageFiles);
  }

  static int? getCounter()=> _preferences.getInt(_keyCounter);

  static Future setUserPIN(String inputPIN) async{
    String hashedPin = getPaddedHashedValue(inputPIN);
    print("Hashed String:\t"+hashedPin);
    await _preferences.setString(_hasedPin, hashedPin);
    setRegisteredTrue();
    print("Setting user pin: "+hashedPin);
  }

  static Future setRegisteredTrue() async{
    await _preferences.setBool(_registered,true);
    print("Setting registered True");
    print(getRegistered());
  }

  static Future setRegisteredFalse() async{
    await _preferences.setBool(_registered,false);
    print("Setting registered False ");
  }

  static bool? getRegistered(){
    return _preferences.getBool(_registered);
  }

  static String? getHashedUserPinCode(){
    return _preferences.getString(_hasedPin);
  }
  static String getPaddedHashedValue(inputPIN){
    String paddedString = inputPIN;
    int paddingLength = inputPIN.length%32;
    for (int i =0;i<paddingLength;i++){
      paddedString += "0";
    }
    return md5.convert(utf8.encode(paddedString)).toString();
  }
  static bool compareHashValues(hash1,hash2){
    if(hash1 == hash2){
      return true;
    }else{
      return false;
    }
  }
}