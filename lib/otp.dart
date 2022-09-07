import 'package:agami/sign.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key, phone}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var maskFormatter = MaskTextInputFormatter(
    mask: '###-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ga'),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          children: const [
                            Text(
                              'Agami Merchant',
                              style: TextStyle(
                                color: Color(0xFF004FC9),
                                fontSize: 24,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                            Text(
                              'Phone verification',
                              style: TextStyle(
                                color: Color(0xFF004FC9),
                                fontSize: 24,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
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
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: Text(
                      'Check your phone. We send you a six digit verification code. Enter the code here.',
                      style: TextStyle(
                        color: Color(0xFF004FC9),
                        fontFamily: 'Roboto Condensed',
                        fontSize: 10,
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      suffix: TextButton(
                        onPressed: () {
                          print('pressd');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF004FC9),
                        ),
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Condensed',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      helperStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'XXX-XXX',
                      hintStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 18,
                      ),
                      labelText: 'Code',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Sign(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFF004FC9),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                              ),
                            ),
                            child: const Text(
                              'EDIT',
                              style: TextStyle(
                                color: Color(0xFF004FC9),
                                fontFamily: 'Roboto Condensed',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004FC9),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                              ),
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
                        ),
                      ],
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
}
