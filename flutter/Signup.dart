import 'package:flutter/material.dart';
import 'package:nitro_img_aes/sharedPref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  return runApp(
    const MaterialApp(
      home: SignupPage(),
    )
  );
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                child: Center(
                  child: SizedBox(
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
