import 'dart:io';

import 'package:agami/Splashscreen.dart';
import 'package:flutter/material.dart';
import './language.dart';
import './devices.dart';
import './business.dart';
import './displayTheme.dart';
import './withdraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

var box = Hive.box('agamiMerchant');

var storage = FirebaseStorage.instance;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  XFile? _pickedFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? avatar = FirebaseAuth.instance.currentUser!.photoURL;
  var selectedLanguage = box.get('language', defaultValue: 1);
  List settingsList = [
    [
      {
        "title": "Business Details",
        "subtitle": "Shop name and location",
        "icon": 0xf3ef,
        "page": 1
      },
      {
        "title": "Language",
        "subtitle": "Change language",
        "icon": 0xf45e,
        "page": 2
      },
      {
        "title": "Theme",
        "subtitle": "Dark and light theme",
        "icon": 0xef9f,
        "page": 3
      },
      {
        "title": "Withdraw",
        "subtitle": "Select withdrawal method",
        "icon": 0xee33,
        "page": 4
      },
      {
        "title": "Devices",
        "subtitle": "Connect web devices",
        "icon": 0xf6a8,
        "page": 5
      },
      {
        "title": "Help and Support",
        "subtitle": "Discuss about problems and bugs",
        "icon": 0xf01f5,
        "page": 6
      },
      {
        "title": "About Agami Merchant",
        "subtitle": "Terms and conditions",
        "icon": 0xf0376,
        "page": 7
      },
      {
        "title": "Logout",
        "subtitle": "Keep account secure",
        "icon": 0xf88b,
        "page": 8
      }
    ],
    [
      {
        "title": "ব্যবসা পরিচিতি",
        "subtitle": "বিপণী বিতানের নাম ও ঠিকানা",
        "icon": 0xf3ef,
        "page": 1
      },
      {"title": "ভাষা", "subtitle": "ভাষা পরিবর্তন", "icon": 0xf45e, "page": 2},
      {
        "title": "দৃশ্য",
        "subtitle": "দৃশ্যমান রঙ পরিবর্তন",
        "icon": 0xef9f,
        "page": 3
      },
      {
        "title": "উত্তোলন",
        "subtitle": "উত্তোলন এর মাধ্যম নির্ধারণ",
        "icon": 0xee33,
        "page": 4
      },
      {
        "title": "ডিভাইস",
        "subtitle": "অন্যান্য ডিভাইস সংযোগ",
        "icon": 0xf6a8,
        "page": 5
      },
      {
        "title": "সাহায্য সহযোগিতা",
        "subtitle": "সমস্যা ও ত্রুটি নিয়ে আলোচনা",
        "icon": 0xf01f5,
        "page": 6
      },
      {
        "title": "আগামি মার্চেন্ট সমন্ধীয়",
        "subtitle": "নিয়ম ও শর্তসমূহ",
        "icon": 0xf0376,
        "page": 7
      },
      {
        "title": "লগ-আউট",
        "subtitle": "একাউন্ট সুরক্ষিত রাখুন",
        "icon": 0xf88b,
        "page": 8
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLanguage == 1 ? 'Settings' : 'বিন্যাস',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontFamily: 'Roboto Condensed, Ador Noirrit',
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (box.get('theme') == 1 || box.get('theme') == 2) {
                        box.put('theme', 3);
                      } else {
                        box.put('theme', 1);
                      }
                    },
                    icon: const Icon(Icons.lightbulb_outline_rounded),
                    color: Theme.of(context).highlightColor,
                  )
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: const AssetImage('assets/default-photo.png'),
                  foregroundImage: NetworkImage('$avatar'),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: _attachImage,
                    splashRadius: 20,
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  for (var options in settingsList[selectedLanguage - 1])
                    InkWell(
                      onTap: () => _handleNavigation(options['page']),
                      child: Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconData(options['icon'],
                                      fontFamily: 'MaterialIcons'),
                                  color: Theme.of(context).highlightColor,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          options['title'],
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontFamily:
                                                'Roboto Condensed, Ador Noirrit',
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          options['subtitle'],
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontFamily:
                                                'Roboto Condensed , Ador Noirrit',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: options ==
                                    settingsList[selectedLanguage - 1][
                                        settingsList[selectedLanguage - 1]
                                                .length -
                                            1]
                                ? false
                                : true,
                            child: Divider(
                              color: Theme.of(context).primaryColorDark,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleNavigation(key) {
    switch (key) {
      case 1:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Business(),
            ),
          );
        }
        break;
      case 2:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Language(),
            ),
          );
        }
        break;
      case 3:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DisplayTheme(),
            ),
          );
        }
        break;
      case 4:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Withdraw(),
            ),
          );
        }
        break;
      case 5:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Devices(),
            ),
          );
        }
        break;
      case 6:
        {
          _redirectHelp();
        }
        break;
      case 7:
        {
          _redirectTerms();
        }
        break;
      case 8:
        {
          _signOut();
        }
        break;
    }
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  void _redirectTerms() async {
    await launchUrl(Uri.parse('https://agamipay.com/terms'));
  }

  void _redirectHelp() async {
    await launchUrl(Uri.parse('https://agamipay.com/support'));
  }

  void _attachImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = pickedImage;
    });
    _cropImage();
  }

  _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Resize image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Theme.of(context).highlightColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Resize image',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      final File imageFile = File(croppedFile.path);
      final phone = FirebaseAuth.instance.currentUser!.phoneNumber;
      final parsedPhone = phone!.split('+')[1];
      final fileName = 'avatar-$parsedPhone.jpg';
      await FirebaseStorage.instance
          .ref('avatar/$fileName')
          .putFile(File(imageFile.path))
          .then((snapshot) async {
        var photoUrl = await snapshot.ref.getDownloadURL();
        await _auth.currentUser!.updatePhotoURL(photoUrl);
        setState(() {
          avatar = _auth.currentUser!.photoURL;
        });
      });
    }
  }
}
