import 'package:flutter/material.dart';
import 'package:languagetool_textfield/languagetool_textfield.dart';



/// Example App main page
// ignore: prefer-match-file-name
class App extends StatefulWidget {
  /// Example app constructor
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Initialize LanguageToolController
  final LanguageToolController _controller = LanguageToolController();


  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
          Container(
          decoration: BoxDecoration(
          color: scheme.primary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 10.0, color: Colors.transparent)),
          width: width,
          height: height / 2.2,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,
            reverse: true,
            padding: const EdgeInsets.all(20.0),
            child: LanguageToolTextField(
              mistakePopup: MistakePopup(popupRenderer: PopupOverlayRenderer()),
              maxLines: null,
              controller: _controller,
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
                  fontSize: 20.0,
                color: scheme.outlineVariant
            ),
          ),
        ),
              ),

            ],
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