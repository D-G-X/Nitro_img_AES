import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nitro_img_aes/main.dart';
import 'package:nitro_img_aes/sharedPref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  return runApp(
    const MaterialApp(
      home: CreatePin(),
    )
  );
}

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  String inputPin = "";
  final textController = TextEditingController();
  bool registered = false;


  @override
  void initState(){
    super.initState();
    registered = SharedPref.getRegistered()!;
    print("CreatePin: init State:"+registered.toString());
  }

  @override
  Widget build(BuildContext context) {
    if(registered){
     return VerifyPin(inputPin1: SharedPref.getHashedUserPinCode()!);
    }
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
            child: Center(
              child: SizedBox(
                child: Image.asset('assets/logo2.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30,0,30,10),
            child: TextFormField(
              cursorColor: Colors.cyan,
              autofocus: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(32),
              ],
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                labelStyle: TextStyle(color: Colors.cyan),
                fillColor: Colors.black,
                filled: true,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan)
                ),
                labelText: 'CREATE YOUR PIN',
              ),
              controller: textController,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  inputPin = textController.text;
                  print("Create Pin:\t"+inputPin);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>VerifyPin(inputPin1: inputPin)));

                }
                ,style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.cyan,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),
                    elevation: 0,
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    // shape: OutlinedBorder(),
                    side: const BorderSide(
                      width: 1.8,
                      color: Colors.cyanAccent,
                    )
                ), child: const Text("CREATE YOUR PIN")),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class VerifyPin extends StatefulWidget {
  final String inputPin1;
  const VerifyPin({Key? key,required this.inputPin1}) : super(key: key);

  @override
  State<VerifyPin> createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {

  String inputPin = "";
  final textController = TextEditingController();
  bool registered = false;

  @override
  void initState(){
    super.initState();
    registered = SharedPref.getRegistered()!;
  }

  @override
  Widget build(BuildContext context) {
    if(SharedPref.getRegistered()!){
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
              child: Center(
                child: SizedBox(
                  child: Image.asset('assets/logo2.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30,0,30,10),
              child: TextFormField(
                cursorColor: Colors.cyan,
                autofocus: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(32),
                ],
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  labelStyle: TextStyle(color:Colors.cyan),
                  fillColor: Colors.black,
                  filled: true,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan)
                  ),
                  labelText: 'ENTER YOUR PIN',
                ),
                controller: textController,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: ()async {
                    inputPin = textController.text;
                    print("Re-Enter Pin:\t"+inputPin);
                    if(widget.inputPin1 == SharedPref.getPaddedHashedValue(inputPin) ){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const HomePage()));
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const CreatePin()));
                    }
                  }
                      ,style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.cyan,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),
                          elevation: 0,
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          // shape: OutlinedBorder(),
                          side: const BorderSide(
                            width: 1.8,
                            color: Colors.cyanAccent,
                          )
                      ), child: const Text("ENTER")),

                ],
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
            child: Center(
              child: SizedBox(
                child: Image.asset('assets/logo2.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30,0,30,10),
            child: TextFormField(
              cursorColor: Colors.cyan,
              autofocus: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(32),
              ],
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                labelStyle: TextStyle(color: Colors.cyan),
                fillColor: Colors.black,
                filled: true,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan)
                ),
                labelText: 'RE-ENTER YOUR PIN',
              ),
              controller: textController,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: ()async {
                  inputPin = textController.text;
                  print("Re-Enter Pin:\t"+inputPin);
                  if(widget.inputPin1 == inputPin ){
                    SharedPref.setUserPIN(inputPin);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const HomePage()));
                  } else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const CreatePin()));
                  }
                }
                    ,style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.cyan,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        // shape: OutlinedBorder(),
                        side: const BorderSide(
                          width: 1.2,
                          color: Colors.cyanAccent,
                        )
                    ), child: const Text("CONFIRM")),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Incorrect PIN Entered'),
      content: const Text('The PIN Entered was incorrect'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, "OK"),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


