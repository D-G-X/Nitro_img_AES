import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static const _keyCounter = 'counter';
  static const _keyListImageFiles = 'encryptedImageFiles';

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
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
}