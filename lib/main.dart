import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/info.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:ocr/Screen/tips.dart';
import 'package:ocr/Utils/image_cropper_page.dart';
import 'package:ocr/Utils/image_picker_class.dart';
import 'package:ocr/Widgets/modal_dialog.dart';
import 'package:flutter/services.dart';
import 'package:ocr/themes/light_theme.dart';
import 'package:ocr/themes/dark_theme.dart';
import 'package:ocr/Screen/mistakeinfo.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      home:
          // const MistakeInfoPage(title: 'Demo Title', error: "Demo Error",),

          const MyHomePage(
        title: 'Demo Home Page',
        index: 0,
        enablePageJump: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.index,
      required this.enablePageJump})
      : super(key: key);

  final String title;
  final int index;
  final bool enablePageJump;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 0;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      currentIndex = widget.index;
      firstTime = false;
    }
    double screenWidth = MediaQuery.of(context).size.width;
    var scheme = Theme.of(context).colorScheme;
    double height = MediaQuery.of(context).size.height;
    var spacerHeight = height / 93.2;
    List<String> titles = ['Home', 'Information', 'Scanning Tips', 'Settings'];
    List<Widget> pages = [
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: spacerHeight * 2,
                ),
                Container(
                  width: screenWidth * 0.25,
                  height: height * 0.0125,
                  color: Colors.red,
                ),
                SizedBox(
                  height: spacerHeight * 2,
                ),
                SizedBox(
                  height: spacerHeight * 2.5,
                  child: FittedBox(
                    child: Text(
                      'Welcome to',
                      style: TextStyle(
                          // fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: scheme.outlineVariant),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  height: spacerHeight / 2,
                ),
                AutoSizeText(
                  'WriteRight',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,

                      color: scheme.outlineVariant),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  minFontSize: 48,
                ),
               SizedBox(
                  height: spacerHeight * 2,
                ),
                AutoSizeText(
                  'Transform your handwritten text in a few simple steps. Tap below to get started.',
                  style: TextStyle(
                      // fontWeight: FontWeight.w900,

                      color: scheme.outlineVariant),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  minFontSize: 20,
                ),
                SizedBox(
                  height: spacerHeight * 1.5,
                ),
                Center(
                  child: Image(
                    image: const AssetImage(
                      'assets/manwriting3.png',
                    ),
                    width: screenWidth,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: spacerHeight * 2.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: screenWidth - 40,
              height: height * 0.15,
              child: ElevatedButton(

                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(scheme.surfaceTint),
                  elevation: const MaterialStatePropertyAll(0),

                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        side: BorderSide(width: 3.5, color: scheme.surface),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 80.0,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[200],
                  ),
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  imagePickerModal(
                    context,
                    onCameraTap: () {
                      HapticFeedback.lightImpact();
                      log("Camera");
                      pickImage(Permission.camera, 'We need access to your camera in order to scan images.', context, source: ImageSource.camera).then(
                        (value) {
                          if (value != '') {
                            imageCropperView(value, context).then(
                              (value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                        noRecognizedPage: false,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      );
                    },
                    onGalleryTap: () {
                      log("Gallery");
                      HapticFeedback.lightImpact();
                        pickImage(Permission.photos, 'We need access to your photo library in order to scan images.', context,source: ImageSource.gallery).then(
                          (value) {
                            if (value != '') {
                              imageCropperView(value, context).then(
                                (value) {
                                  if (value != '') {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => RecognizePage(
                                          path: value,
                                          noRecognizedPage: false,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );

                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: spacerHeight,
          ),
        ],
      ),
      const InfoPage(),
      TipsPage(),
      const Text(
        'Page 3',
        style: TextStyle(fontSize: 50),
      ),
    ];
    return Scaffold(
      backgroundColor: scheme.background,

      appBar: AppBar(

        backgroundColor: scheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text(
          titles[currentIndex],
          style: TextStyle(color: scheme.outline, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: screenWidth * 0.15725,
            right: screenWidth * 0.15725,
            top: spacerHeight * 2,
            bottom: spacerHeight*4),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          color: scheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: listOfIcons.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? screenWidth * .12 : 0,
                      width: index == currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.redAccent.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(listOfIcons[index],
                      size: screenWidth * .076,
                      color: index == currentIndex
                          ? scheme.surfaceTint
                          : scheme.tertiary),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<IconData> listOfIcons = [
  Icons.home_rounded,
  Icons.info_rounded,
  Icons.tips_and_updates_rounded,
];

