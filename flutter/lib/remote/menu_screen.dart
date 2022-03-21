import 'package:flutter/material.dart';
import 'package:nitro_img_aes/remote/setup_screen.dart';

import 'auth_screen.dart';

// D:\COLLEGE\nitro_img_aes\lib\remote\auth_screen.dart
class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nitro"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white54,
      body: Column(
        children: [
          Image.asset('assets/N2.png',
            height: 300,
            width: 300,
            // color: Colors.white54,
            // // colorBlendMode: BlendMode.color,
            fit: BoxFit.fitWidth,),
          const SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700], // background
                  onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )// foreground
                ),

                child: const Text(
                    "Enter PIN"
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                }),
              const SizedBox(width: 48),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[700], // background
                    onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )// foreground
                  ),
                child: const Text(
                    "Setup PIN"
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetupScreen()),
                  );
                })
            ],
          ),
        ],
      ),
    );
  }
}