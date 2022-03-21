import 'package:encrypt/encrypt.dart' as encryptor;

class dartEncryptor{
  static final key = encryptor.Key.fromUtf8("Group2_1234567890123456789012345");
  static final IV = encryptor.IV.fromUtf8("Nitro");
  static final encryAlgo = encryptor.Encrypter(encryptor.AES(key));
}