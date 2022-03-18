import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitro_img_aes/gallery.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(
  const MaterialApp(
    home: HomePage(),
  )
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int p = 0;
  static const platform = MethodChannel("com.flutter.nitro/AES");

  void Printy(String path) async{
    String value;
    try{
      value = await platform.invokeMethod('Printy',{
        "path": path,
      });
      print("From Java:" + value);
    }catch(e){
      print("ERROR: Printy: "+e.toString());
    }
  }

  List<String> encryptedImageFiles = [];
  int counter = 0;

  final ImagePicker _picker = ImagePicker();

  Future<String> _pickImage() async{
    try{
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      print("_pickImage()\n"+pickedFile.path.toString());
      encryptedImageFiles.add(pickedFile.path);
      counter = encryptedImageFiles.length;
      Printy(pickedFile.path);
      return pickedFile.path;
    } catch (e){
      if (kDebugMode) {
        print("Image picker Error: "+e.toString());
      }
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15,30,15,0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Counter
                    SizedBox(
                      width: 190,
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              counter = encryptedImageFiles.length;
                              print("Counter updated");
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.cyanAccent,
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.all(25),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            // shape: OutlinedBorder(),
                            side: const BorderSide(
                                width: 1.8,
                                color: Colors.cyanAccent,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text('$counter',
                              style: const TextStyle(
                                fontSize: 32
                              )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text("Images Encrypted")
                            ],
                          )
                      ),
                    ),

                    // Upload Button
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                          onPressed: (){
                            String imageFile = _pickImage().toString();
                            print("Path: "+imageFile.toString());
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              onPrimary: Colors.cyanAccent,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,

                              ),
                              elevation: 0,
                              padding: const EdgeInsets.all(25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              // shape: OutlinedBorder(),
                              side: const BorderSide(
                                width: 1.8,
                                color: Colors.cyanAccent,
                              )
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.file_upload,
                              size: 46,),
                              SizedBox(
                                height: 3,
                              ),
                              Text("Upload Images")
                            ],
                          )
                      ),
                    )
                  ],

                ),


              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery Button
                    SizedBox(
                      width: 370,
                      child: ElevatedButton(
                          onPressed: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Gallery(encryptedImageFiles: encryptedImageFiles)));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              onPrimary: Colors.cyanAccent,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.all(25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              // shape: OutlinedBorder(),
                              side: const BorderSide(
                                width: 1.8,
                                color: Colors.cyanAccent,
                              )
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.image,
                              size: 46,),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Gallery Image")
                            ],
                          ) ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),

    );
  }
}
