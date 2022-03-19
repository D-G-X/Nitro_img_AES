import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ImagePreview.dart';

class GalleryTile extends StatefulWidget {
  final String path;
  final List<String> encryptedImageFiles;
  const GalleryTile({Key? key, required this.path, required this.encryptedImageFiles}) : super(key: key);

  @override
  State<GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<GalleryTile> {
  static const platform = MethodChannel("com.flutter.nitro/AES");

  void decryptImage(String path) async{
    String value;
    try{
      value  = await platform.invokeMethod('decryptImage',{
        "path": path,
      });
      print("From Java decrypt:" + value);

    }catch(e){
      print("ERROR: decryptImage: "+e.toString());
    }
  }

  @override void initState() {
    super.initState();
    // decryptImage(widget.path);
  }


  @override
  Widget build(BuildContext context){
    while(true) {
      try{
        File file = File(widget.path);
        break;
      } on FileSystemException{
        print("encrypted File not found");
      }
    }
    decryptImage(widget.path);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePreview(path: widget.path,
          encryptedImageFiles: widget.encryptedImageFiles,
          // delete: (){
          //   print(encryptedImageFiles.length);
          //   encryptedImageFiles.remove(encryptedImageFiles[index]);
          //   print(encryptedImageFiles.length);
          // },
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
              File(widget.path),
              scale: 1
          ),
          fit: BoxFit.contain,

        ),
      ),);
  }
}
