import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitro_img_aes/dartEncrypt/dartEncryptor.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encryptor;

void main() => runApp(const MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String encryptedFile = "";
  final ImagePicker _picker = ImagePicker();

  Future<Directory?> get getAppDir async {
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  _getDecryptedImage(Directory d) async {
    Uint8List encryptedBytes = await _readData(d.path+"/"+encryptedFile+".aes");
    var decryptedBytes = await _decryptBytes(encryptedBytes);
    String absolutePathOfDecryptedFile = await _writeBytes(decryptedBytes, d.path+"/"+encryptedFile);
    print("Image Decrypted. File saved at:\t"+absolutePathOfDecryptedFile);
  }

  Future<Uint8List> _readData(encryptedFilePath) async{
    File file = File(encryptedFilePath);
    return await file.readAsBytes();
  }

  _decryptBytes(encryptedBytes){
    encryptor.Encrypted en = encryptor.Encrypted(encryptedBytes);
    return dartEncryptor.encryAlgo.decryptBytes(en,iv:dartEncryptor.IV);
  }

  _getImageAndEncrypt(Directory d) async{
    String path = await _pickImage();
    File imageFile = File(path);

    Uint8List imageBytes = imageFile.readAsBytesSync();
    var encryptedBytes = _encryptBytes(imageBytes);

    String abosulutePathOfEncryptedFile = await _writeBytes(encryptedBytes,d.path+"/"+encryptedFile+".aes");
    print("Image Encrypted. File saved at:\t"+abosulutePathOfEncryptedFile);

    var delete = imageFile.delete();
    print("Original Image Deleted");
  }

  _pickImage() async{
    try{
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      print("pickImage()\n"+pickedFile.path.toString());
      encryptedFile = basename(pickedFile.path);
      print(basename(pickedFile.path));
      return pickedFile.path;
    } catch (e){
      if (kDebugMode) {
        print("Image picker Error: "+e.toString());
      }
      return "";
    }
  }

  _encryptBytes(Uint8List imageBytes){
    final encryptedBytes = dartEncryptor.encryAlgo.encryptBytes(List.from(imageBytes),iv:dartEncryptor.IV);
    return encryptedBytes.bytes;
  }

  Future<String> _writeBytes(dataBytes, filePath) async {
    File file = File(filePath);
    await file.writeAsBytes(dataBytes);
    return file.absolute.toString();
  }

  Future<Directory> get getExternalVisibleDirectoryDir async{
    if(await Directory('/storage/emulated/0/MyEncFolder').exists()){
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    } else {
      await Directory('/storage/emulated/0/MyEncFolder').create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dart Encryp API"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  Directory? hiddenDirectory = await getAppDir;
                  print(hiddenDirectory);
                  // Directory externalDirectory = await getExternalVisibleDirectoryDir;
                  _getImageAndEncrypt(hiddenDirectory!);
                  print(encryptedFile);
                },
                child: const Text("Encrypt")),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  // Directory d = await getExternalVisibleDirectoryDir;
                  Directory? hiddenDirectory = await getAppDir;
                  _getDecryptedImage(hiddenDirectory!);
                },
                child: const Text("Decrypt"))
          ],
        ),
      ),
    );
  }
}
