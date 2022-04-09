import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:nitro_img_aes/dartEncrypt/dartEncryptor.dart';
import 'package:path_provider/path_provider.dart';
import 'ImagePreview.dart';
import 'package:encrypt/encrypt.dart' as encryptor;

class GalleryTile extends StatefulWidget {
  final String path;
  final List<String> encryptedImageFiles;
  const GalleryTile({Key? key, required this.path, required this.encryptedImageFiles}) : super(key: key);

  @override
  State<GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<GalleryTile> {
  // static const platform = MethodChannel("com.flutter.nitro/AES");
  //
  // void decryptImage(String path) async{
  //   String value;
  //   try{
  //     print("EncryptedFile Exists: "+(await File(path+".aes").exists()).toString());
  //     print("OriginalFile Exists: "+(await File(path).exists()).toString());
  //     value  = await platform.invokeMethod('decryptImage',{
  //       "path": path,
  //     });
  //     print("From Java decrypt:" + value);
  //
  //   }catch(e){
  //     print("ERROR: decryptImage: "+e.toString());
  //   }
  // }
  String tempDirPath = "/data/user/0/dgx.nitro.nitro_img_aes/cache/";
  Future<Directory?> get getAppDir async {
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  _getDecryptedImage(Directory d) async {
    Directory? appDocDir = await getAppDir;
    Uint8List encryptedBytes = await _readData(appDocDir!.path+"/"+widget.path+".aes");
    var decryptedBytes = await _decryptBytes(encryptedBytes);
    String absolutePathOfDecryptedFile = await _writeBytes(decryptedBytes, d.path+"/"+widget.path);
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

  Future<String> _writeBytes(dataBytes, filePath) async {
    File file = File(filePath);
    await file.writeAsBytes(dataBytes);
    return file.absolute.toString();
  }

  late Future decryImage;

  @override void initState(){
    super.initState();
    _getTemporaryDir();
  }

  _decryptImages() async{
    Directory tempDirectory = await getTemporaryDirectory();
    tempDirPath = tempDirectory.path;
    // tempDirPath = tempDirectory.path;
    print(tempDirectory);
    await _getDecryptedImage(tempDirectory);
  }

  _getTemporaryDir() async{
    Directory tempDir = await getTemporaryDirectory();
    tempDirPath = tempDir.path;
    print("_getTemporaryDir():\t"+tempDir.path);
  }

  @override
  Widget build(BuildContext context){
    // print(File("/data/user/0/dgx.nitro.nitro_img_aes/cache/"+widget.path).existsSync());

    print(File(tempDirPath+"/"+widget.path).existsSync());

    if(File(tempDirPath+"/"+widget.path).existsSync()){
      print("if true:\t"+tempDirPath+"/"+widget.path);
      print("already Exists");
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePreview(path: tempDirPath+"/"+widget.path,
            encryptedImageFiles: widget.encryptedImageFiles,
          )));
        },
        child: Container(
          // color: Colors.white12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.black,
            // border: Border.all(color: Colors.cyanAccent, width: 2)
          ),
          child: Image(
            image: FileImage(
                File(tempDirPath+"/"+widget.path),
                scale: 1
            ),
            fit: BoxFit.contain,

          ),
        ),);
    } else {
    return FutureBuilder(
      future: _decryptImages(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            print("Idle");
            return Container(
              // color: Colors.white12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.black,
                // border: Border.all(color: Colors.cyanAccent, width: 2)
              ),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            print("Decrypting");
            return Container(
              // color: Colors.white12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.black,
                // border: Border.all(color: Colors.cyanAccent, width: 2)
              ),
            );
          case ConnectionState.done:
            print("Decrypted");
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePreview(path: tempDirPath+"/"+widget.path,
                  encryptedImageFiles: widget.encryptedImageFiles,
                )));
              },
              child: Container(
                // color: Colors.white12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black,
                  // border: Border.all(color: Colors.cyanAccent, width: 2)
                ),
                child: Image(
                  image: FileImage(
                      File(tempDirPath+"/"+widget.path),
                      scale: 1
                  ),
                  fit: BoxFit.contain,

                ),
              ),);
          default:
            return Container(
              // color: Colors.white12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.black,
                // border: Border.all(color: Colors.cyanAccent, width: 2)
              ),
            );
        }
      },
    );}
  }
}
