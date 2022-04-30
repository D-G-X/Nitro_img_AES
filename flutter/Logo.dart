import 'package:flutter/material.dart';

void main() {
  return runApp(
    const MaterialApp(
      home: LogoScreen(),
    )
  );
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
            child: Center(
              child: SizedBox(
                child: Image.asset('assets/logo.png'),
              ),
            ),
          )
        ],
      ),

    );
  }
}
