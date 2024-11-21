import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MistakeInfoPage extends StatefulWidget {
  final String title;
  final String error;

  const MistakeInfoPage({Key? key, required this.title, required this.error})
      : super(key: key);

  @override
  State<MistakeInfoPage> createState() => _MistakeInfoPageState();
}

class _MistakeInfoPageState extends State<MistakeInfoPage> {
  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int index = 0;
    if (widget.title == "MISSPELLING") {
      index = 0;
    } else if (widget.title == "TYPOGRAPHICAL") {
      index = 1;
    } else if (widget.title == "GRAMMAR") {
      index = 2;
    } else if (widget.title == "LOGIC") {
      index = 3;
    } else {
      index = 4;
    }
    List<String> descriptions = [
      'Misspelling',
      'Typographical',
      'Grammar',
      'Logic',
      'Other'
    ];
    List<String> incorrect = [
      'I was eatin some apples.',
      'i was eating some apples.',
      'Last Saturday I ate some apples.',
          'I ate an apple on Sunday, May 8th, 2020.'
    ];
    List<String> correct = [
      'I was eating some apples.',
      'I was eating some apples.',
      'Last Saturday, I ate some apples.',
      'I ate an apple on Friday, May 8th, 2020.'
    ];
    List<String> issue = [
      "First sentence spelled 'eating' incorrectly.",
      'First sentence did not capitalize the first letter of the sentence.',
      "First sentence did not use proper punctuation (forgot a ',').",
      "First sentence used incorrect logic (May 8th, 2020 was a Friday not a Sunday)."
    ];
    List<String> details = [
      'A misspelling error is caused by an incorrectly spelt word.',
      'A typographical error (also referred to as a typo) is caused by a word that is spelt incorrectly and is similar to misspellings. It differs, however, in the sense that typographical errors are more commonly caused by careless mistakes such as the accidental press of a key while typing, or forgetting to capitalize a word while writing.',
      'Grammatical errors occur when the text does not follow standard grammar rules and conventions.'
    ];
    List<String> advice = [
      'To avoid misspelling errors in the future, be sure to look carefully over your spellings, and double check tricky words! Consulting a friend or a dictionary never hurts!',
      "To avoid typographical errors in the future, be deliberate when writing and focus on your handwriting/typing to avoid any careless mistakes.",
      'To avoid grammatical errors in the future, be sure that your sentence complies with all common grammatical rules and regulations, most notably the usage of proper punctuation, sentence structure, and subject-verb agreement.'
    ];
    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        backgroundColor: scheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text(
          widget.title,
          style: TextStyle(color: scheme.outline, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.0125,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    'Your Error',
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    widget.error.replaceAll('â', "'").replaceAll(RegExp("[^A-Za-z ']"), ''),
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Error Information',
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    details[index],
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    maxLines: 8,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Example of Error',
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.close, color: scheme.surfaceTint,),
                      const SizedBox(
                        width: 20,
                      ),
                      AutoSizeText(
                        incorrect[index],
                        style: TextStyle(
                            color: scheme.outlineVariant,
                            // fontSize: 20,
                            fontWeight: FontWeight.w300,
                            // decoration: TextDecoration.underline,
                            // decorationColor: Colors.red,
                            // decorationThickness: 3
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    'Issue: ${issue[index]} ',
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.check, color: Colors.green,),
                      const SizedBox(
                        width: 20,
                      ),
                      AutoSizeText(
                        correct[index],
                        style: TextStyle(
                            color: scheme.outlineVariant,
                            // fontSize: 20,
                            fontWeight: FontWeight.w300,
                            // decoration: TextDecoration.underline,
                            // decorationColor: Colors.green,
                            // decorationThickness: 3
                        ),
                        maxLines:2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Advice',
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    advice[index],
                    style: TextStyle(
                        color: scheme.outlineVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    maxLines: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
