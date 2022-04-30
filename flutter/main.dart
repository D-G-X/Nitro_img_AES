import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitro_img_aes/gallery.dart';
import 'dart:async';
import 'package:nitro_img_aes/dartEncrypt/dartEncryptor.dart';
import 'package:nitro_img_aes/sharedPref.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPref.init();
//
//   return runApp(
//       const MaterialApp(
//         home: HomePage(),
//       )
//   );
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    print("Initializing State of the Main application");
    print(SharedPref.getCounter());
    print(SharedPref.getEncryptedImageFiles());
    counterRefresh.value = SharedPref.getCounter() ?? 0;
    encryptedImageFiles = SharedPref.getEncryptedImageFiles()??[];
    print("HomePage: init State:"+SharedPref.getRegistered()!.toString());
  }

  List<String> encryptedImageFiles = [];
  final ValueNotifier<int> counterRefresh = ValueNotifier<int>(0);

  final ImagePicker _picker = ImagePicker();

  Future<Directory?> get getAppDir async {
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  _getImageAndEncrypt(Directory d) async{
    String path = await _pickImage();
    File imageFile = File(path);

    Uint8List imageBytes = imageFile.readAsBytesSync();
    var encryptedBytes = _encryptBytes(imageBytes);

    String abosulutePathOfEncryptedFile = await _writeBytes(encryptedBytes,d.path+"/"+encryptedImageFiles[encryptedImageFiles.length-1]+".aes");
    print("Image Encrypted. File saved at:\t"+abosulutePathOfEncryptedFile);

    var delete = imageFile.delete();
    print("Original Image Deleted");
    counterRefresh.value = encryptedImageFiles.length;
  }

  Future<String> _pickImage() async{
    try{
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      print("_pickImage():\t"+pickedFile.path.toString());
      encryptedImageFiles.add(basename(pickedFile.path));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        // padding: const EdgeInsets.fromLTRB(15,30,15,0),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Container(
          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                child: Center(
                  child: SizedBox(
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              )
              ,Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Counter
                    SizedBox(
                      width: 190,
                      child: ValueListenableBuilder<int>(
                        valueListenable: counterRefresh,
                        builder: (context, value, child) {
                          return ElevatedButton(
                            onPressed: (){
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
                              children: [Text('$value',
                                  style: const TextStyle(
                                      fontSize: 32
                                  )),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text("Images Encrypted")
                              ],
                            )
                        );},
                      ),
                    ),

                    // Upload Button
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                          onPressed: () async{
                            Directory? hiddenDirectory = await getAppDir;
                            print(hiddenDirectory);
                            // Directory externalDirectory = await getExternalVisibleDirectoryDir;
                            await _getImageAndEncrypt(hiddenDirectory!);

                            await SharedPref.setCounter(counterRefresh.value);
                            await SharedPref.setEncryptedImageFiles(encryptedImageFiles);
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
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery Button
                    SizedBox(
                      width: 370,
                      child: ElevatedButton(
                          onPressed: ()async{
                            await Navigator.push(context, MaterialPageRoute(builder: (context)=> Gallery(encryptedImageFiles: encryptedImageFiles)));
                            counterRefresh.value = encryptedImageFiles.length;
                            await SharedPref.setCounter(counterRefresh.value);
                            await SharedPref.setEncryptedImageFiles(encryptedImageFiles);

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

