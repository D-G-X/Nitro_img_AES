import 'package:flutter/material.dart';
import 'package:nitro_img_aes/remote/menu_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Code Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity ,
        fontFamily: 'Gotham'// ?
      ),
      home: const MenuScreen(),
    );
  }
}