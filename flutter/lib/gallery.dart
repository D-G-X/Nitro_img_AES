import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nitro_img_aes/ImagePreview.dart';


class Gallery extends StatelessWidget {
  final List<String> encryptedImageFiles;
  const Gallery({Key? key, required this.encryptedImageFiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: Container(
            // height: 70,
            margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
            child: const Text(
              'Gallery',
              style: TextStyle(
                color: Colors.white,
                fontSize: 44
              ),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),

      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        color: Colors.grey[900],
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: List.generate(encryptedImageFiles.length, (index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePreview(path: encryptedImageFiles[index],
                encryptedImageFiles: encryptedImageFiles,
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
                      File(encryptedImageFiles[index]),
                      scale: 1
                  ),
                ),
              ),);
          }
            )


          //   [
          //   GestureDetector(
          //   onTap: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePreview(path: '/data/user/0/dgx.nitro.nitro_img_aes/cache/image_picker7423518437880582162.jpg')));
          //   },
          //   child: Container(
          //   // color: Colors.white12,
          //   decoration: BoxDecoration(
          //   borderRadius
          // }: BorderRadius.circular(2),
          //         color: Colors.white,
          //         // border: Border.all(color: Colors.cyanAccent, width: 2)
          //       ),
          //       child: Image(
          //         image: FileImage(
          //           File('/data/user/0/dgx.nitro.nitro_img_aes/cache/image_picker7423518437880582162.jpg'),
          //           scale: 1
          //         ),
          //       ),
          //     ),
          //   ),
          //
          // ],
        ),
      ),
    );
  }
}


//gesture detector for making container interactive : https://stackoverflow.com/questions/43692923/flutter-container-onpressed
//List.generate() to create image cards on the grid : https://www.javatpoint.com/flutter-gridview