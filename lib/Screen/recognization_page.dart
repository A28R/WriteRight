import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ocr/Screen/grammar_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr/main.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  final bool noRecognizedPage;

  const RecognizePage({Key? key, this.path, required this.noRecognizedPage})
      : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {

  bool _isBusy = false;
  double font_size = 20.0;
  double currentValue = 20;
  String value = '';
  bool dispNoPage = true;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.noRecognizedPage == false && controller.text.isEmpty) {
      dispNoPage = true;
    } else {
      dispNoPage = false;
    }

    var scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: scheme.background,
        appBar: AppBar(
          backgroundColor: scheme.primary,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: Text(
            'Recognized Text',
            style:
                TextStyle(color: scheme.outline, fontWeight: FontWeight.bold),
          ),
        ),
        body: _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: !dispNoPage
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        reverse: true,
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 40.0),
                                    child: Text(
                                      'A',
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: CupertinoSlider(
                                      thumbColor: scheme.primary,
                                      activeColor: scheme.primary,
                                      value: currentValue,
                                      min: 12.0,
                                      max: 40.0,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            currentValue = value;
                                            font_size = currentValue;
                                          },
                                        );
                                      },
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.only(right: 40.0),
                                    child: Text(
                                      'A',
                                      style: TextStyle(fontSize: 48.0),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Edit the text below to correct for scanning mistakes.', style: TextStyle(color: scheme.outline, fontSize: 14, ), textAlign: TextAlign.center,),
                              const SizedBox(
                                height: 40,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    color: scheme.primary,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 3.0, color: scheme.secondary)),
                                width: width,
                                height: height / 2.2,
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextFormField(
                                    cursorColor: scheme.tertiary,
                                    maxLines: null,
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.redAccent,
                                                width: 3.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 3.0)),
                                        hintText: "Text goes here..."),
                                    style: TextStyle(
                                        fontSize: font_size,
                                        color: scheme.outline),
                                    autocorrect: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: height * 0.1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                          setState(() {
                                            value = controller.text;
                                            log(value);
                                          });
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyHomePage(
                                                        title: 'Demo Home Page',
                                                        index: 0,
                                                        enablePageJump: false,
                                                      )));
                                        },
                                        style: ButtonStyle(
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    0.0),
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                const EdgeInsets.all(20.0)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0)),
                                                  side: BorderSide(
                                                      color: scheme.secondary,
                                                      width: 2.0)),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    scheme.primary)),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Icon(
                                              Icons.arrow_back_rounded,
                                              color: scheme.outlineVariant,

                                              size: height/23.3,
                                            ),
                                            // const SizedBox(width: 10,),
                                            Icon(
                                              Icons.home_rounded, size: height/23.3,
                                              color: scheme.outlineVariant,
                                            ),
                                            // Text(
                                            //   'Proceed to grammar check.',
                                            //   style: TextStyle(
                                            //       color: scheme.outlineVariant,
                                            //       fontSize: 20.0,
                                            //       fontWeight: FontWeight.w700),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: height * 0.1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                          setState(() {
                                            value = controller.text;
                                            log(value);
                                          });
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GrammarPage(
                                                          value: value)));
                                        },
                                        style: ButtonStyle(
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    0.0),
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                const EdgeInsets.all(20.0)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  30.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30.0)),
                                                  side: BorderSide(
                                                      color: scheme.surfaceVariant,
                                                      width: 2.0)),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    scheme.surfaceTint)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              'Grammar Check',
                                              style: TextStyle(
                                                  color: scheme.outline,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(width: 10,),
                                            Icon(Icons.arrow_forward_sharp, color: scheme.outline, size: height/23.3,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                            ],
                          ),
                        ),
                    )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView(

                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.cancel_outlined,
                                color: scheme.surfaceTint,
                                size: width / 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'No Text Recognized',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: scheme.outlineVariant,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  height: 40.0,
                                  thickness: 3.0,
                                  color: scheme.secondary,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                            title: 'Demo Home Page',
                                            index: 2,
                                            enablePageJump: false,
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: scheme.primary,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 10.0),
                                    height: height / 10,
                                    width: width * 0.9,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Icon(
                                            Icons.tips_and_updates_rounded,
                                            color: scheme.surfaceTint,
                                            size: 50.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: AutoSizeText(
                                            'See Tips',
                                            minFontSize: 20,
                                            style: TextStyle(
                                                color: scheme.outlineVariant,
                                                // fontSize: 24.0,

                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RecognizePage(
                                            path: widget.path,
                                            noRecognizedPage: true,
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: scheme.primary,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 10.0),
                                    height: height / 10,
                                    width: width * 0.9,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Icon(
                                            Icons.text_fields_rounded,
                                            color: scheme.surfaceTint,
                                            size: 50.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: AutoSizeText(
                                            'Enter Text Manually',
                                            minFontSize: 20,
                                            style: TextStyle(
                                                color: scheme.outlineVariant,
                                                // fontSize: 24.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                            title: 'Demo Home Page',
                                            index: 0,
                                            enablePageJump: false,
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: scheme.surfaceTint,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    height: height / 7,
                                    width: width * 0.9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Icon(
                                            Icons.home,
                                            color: Colors.grey[300],
                                            size: 50.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            'Back to Home',
                                            style: TextStyle(
                                                color: Colors.grey[300],
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);
    recognizedText.text.replaceAll('  ', " ").replaceAll('  ', " ").replaceAll('  ', " ");
    controller.text = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}
