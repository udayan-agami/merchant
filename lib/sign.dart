import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import './otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pin.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  var phone = '';
  var maskFormatter = MaskTextInputFormatter(
    mask: '&*%##-######',
    filter: {
      "#": RegExp(r'[0-9]'),
      "%": RegExp(r'[3-9]'),
      "&": RegExp(r'[0]'),
      "*": RegExp(r'[1]'),
    },
    type: MaskAutoCompletionType.lazy,
  );
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Theme.of(context).primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
      backgroundColor: const Color(0xFF403255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                width: double.infinity,
                height: 500,
                child: Image.asset(
                  './assets/illustration-1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Agami Merchant',
                              style: TextStyle(
                                color: Color(0xFF004FC9),
                                fontSize: 24,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Color(0xFF004FC9),
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                                Text(
                                  ' or ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Color(0xFF004FC9),
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 3,
                      color: Color(0xFF004FC9),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '01XXX-XXXXXX',
                      hintStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 18,
                      ),
                      labelText: 'Phone number',
                      labelStyle: const TextStyle(
                        fontFamily: 'Roboto Condensed',
                        //fontSize: 16,
                        color: Color(0xFF004FC9),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color(0xFF004FC9),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color(0xFF004FC9),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF004FC9),
                      fontSize: 18,
                      fontFamily: 'Roboto Condensed',
                    ),
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    cursorColor: const Color(0xFF004FC9),
                    inputFormatters: [maskFormatter],
                    onChanged: (value) => setState(() {
                      phone = value;
                    }),
                    autofocus: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: _fetchPhone,
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,

                        primary: maskFormatter.getUnmaskedText().length == 11
                            ? const Color(0xFF004FC9)
                            : const Color.fromARGB(255, 145, 161, 184),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto Condensed',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchPhone() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: '+88${maskFormatter.getUnmaskedText()}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Pin(),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print('error sending otp');
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Otp(phone: phone, verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
