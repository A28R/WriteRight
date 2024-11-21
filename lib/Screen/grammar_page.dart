import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:language_tool/language_tool.dart';
import 'package:flutter/material.dart';
import 'package:languagetool_textfield/languagetool_textfield.dart';
import 'package:ocr/main.dart';

class GrammarPage extends StatefulWidget {
  final bool isLoading = false;
  final dynamic value;

  const GrammarPage({Key? mykey, this.value}) : super(key: mykey);

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  final LanguageToolController _controller = LanguageToolController();

  double currentValue = 20;
  double font_size = 20.0;
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
  }

  final tool = LanguageTool();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (firstTime){
      _controller.text = widget.value;
      firstTime = false;


    }
    var scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: scheme.background,
          appBar: AppBar(
            backgroundColor: scheme.primary,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            title: Text(
              'Grammar Check',
              style:
                  TextStyle(color: scheme.outline, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                    height: 5,
                  ),
                  Text('Corrections will appear as underlines, tap on them to view details.', style: TextStyle(color: scheme.outline, fontSize: 14, ), textAlign: TextAlign.center,),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3.0, color: scheme.secondary)),
                    width: width,
                    height: height * 0.55,
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      padding: const EdgeInsets.all(10.0),
                      child: LanguageToolTextField(

                        mistakePopup:
                            MistakePopup(popupRenderer: PopupOverlayRenderer()),
                        maxLines: null,
                        controller: _controller,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 3.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0)),
                            hintText: "Text goes here..."),
                        style: TextStyle(
                            fontSize: font_size, color: scheme.outlineVariant),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: 'Demo Home Page',
                            index: 0,
                            enablePageJump: false,
                          )));},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              side: BorderSide(
                                  color: scheme.surfaceVariant, width: 3.0)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(scheme.surfaceTint),
                      ),
                      child: Icon(Icons.home_rounded, size: height/18, color: Colors.white,)


                      // const FittedBox(
                      //     fit: BoxFit.fitHeight ,
                      //     child: Text(
                      //   'Back To Home',
                      //   style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                      // )),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
