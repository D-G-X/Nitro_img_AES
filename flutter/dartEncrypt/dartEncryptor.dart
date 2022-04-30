import 'package:encrypt/encrypt.dart' as encryptor;
import 'package:nitro_img_aes/sharedPref.dart';

class dartEncryptor{
  static final key = encryptor.Key.fromUtf8(SharedPref.getHashedUserPinCode().toString());
  static final IV = encryptor.IV.fromUtf8("Nitro");
  static final encryAlgo = encryptor.Encrypter(encryptor.AES(key));
}