import 'dart:io';

import 'package:flutter/material.dart';

import 'gallery.dart';

// void main() => runApp(const MaterialApp(
//   home: ImagePreview(path: '/data/user/0/dgx.nitro.nitro_img_aes/cache/image_picker7423518437880582162.jpg',),
// ));

class ImagePreview extends StatefulWidget {
  final String path;
  final List<String> encryptedImageFiles;
  // final Function() delete;
  const ImagePreview({Key? key, required this.path,
    required this.encryptedImageFiles
    // required this.delete
  }) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const  Size.fromHeight(70),
        child: AppBar(
          title: Container(
            // height: 70,
            margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
            child: const Text(
              'Preview',
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
        padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 500,
                  decoration: const BoxDecoration(
                    // color: Colors.grey,
                    // border: Border.all(color: Colors.cyanAccent, width: 2),
                  ),
                  child: Image(
                    image: FileImage(
                      File(widget.path)
                    ),
                  ),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 370,
                  child: ElevatedButton(
                        onPressed:(){
                          setState(() {
                            widget.encryptedImageFiles.remove(widget.path);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Gallery(encryptedImageFiles: widget.encryptedImageFiles)));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.redAccent,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        // shape: OutlinedBorder(),
                        side: const BorderSide(
                          width: 1.8,
                          color: Colors.redAccent,
                        )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                          Icon(Icons.delete,
                              size: 24,),
                          SizedBox(
                              width: 10,
                          ),
                          Text("Delete")
                        ],
                      ) ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

