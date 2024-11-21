import 'package:highlight_text/highlight_text.dart';
import 'package:language_tool/language_tool.dart';
import 'package:flutter/material.dart';

class GrammarPage extends StatefulWidget {
  final bool isLoading = false;
  final dynamic value;

  GrammarPage({Key? mykey, this.value}) : super(key: mykey);

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  List mistakes = [];
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    checkgrammar(widget.value);
  }

  final tool = LanguageTool();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, HighlightedWord> words = {
      "elephant": HighlightedWord(
        onTap: () {},
        textStyle: TextStyle(
            color: scheme.outline,
            fontSize: 20.0,
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.redAccent,
            decorationThickness: 3,
            fontWeight: FontWeight.bold),
      ),
    };
    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        backgroundColor: scheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text(
          'Grammar Check',
          style: TextStyle(color: scheme.outline, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isBusy == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(top: 40.0),
              width: width,
              height: height * 0.35,
              decoration: BoxDecoration(
                  color: scheme.background,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10.0))),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextHighlight(
                  text: widget.value,
                  words: words,
                  textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: scheme.outlineVariant),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(20.0)),
                  border:
                  Border.all(width: 5.0, color: Colors.transparent)),
              height: 0.35 * height,
              width: width,
              child: Card(
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                borderOnForeground: false,
                child: mistakes.isNotEmpty
                    ? ListView.separated(
                    padding: const EdgeInsets.all(5.0),
                    itemCount: mistakes.length,
                    itemBuilder: (context, index) {
                      var currentMistake = mistakes[index];
                      return MistakeCard(
                          possibleCorrections:
                          currentMistake['possibleCorrections'],
                          issue: currentMistake['Issue'],
                          issueType: currentMistake['IssueType']);
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 10,
                    ))
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No mistakes!',
                        style: TextStyle(color: scheme.outlineVariant, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Please understand that WriteRight may have missed potential errors in your text.',
                          style: TextStyle(color: scheme.outlineVariant, fontSize: 14,  ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        side: BorderSide(color: Colors.red)),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text('Press me'),),
          ],
        ),
      ),
    );
  }

  void checkgrammar(writing) async {
    final tool = LanguageTool();

    final badSentences = writing;
    setState(() {
      _isBusy = true;
    });
    // Works for spelling mistakes.
    var result = await tool.check(badSentences);

    markMistakes(result, badSentences);

    // Logic check.
    result = await tool.check(badSentences);
    setState(() {
      _isBusy = false;
    });
    printDetails(result);
    print(mistakes.length);
  }

  ///Prints every property for every [WritingMistake] passed.
  void printDetails(List<WritingMistake> result) {
    for (final mistake in result) {
      var randMistake = new Map();
      randMistake['Issue'] = mistake.message;
      randMistake['IssueType'] = mistake.issueDescription;
      randMistake['PositionedAt'] = mistake.offset;
      randMistake['possibleCorrections'] = mistake.replacements;
      mistakes.add(randMistake);
      // print('''
      //     Issue: ${mistake.message}
      //     IssueType: ${mistake.issueDescription}
      //     positioned at: ${mistake.offset}
      //     with the lengh of ${mistake.length}.
      //     Possible corrections: ${mistake.replacements}
      // ''');
    }
  }

  void markMistakes(List<WritingMistake> result, String sentence) {
    var text = sentence;
    // Color codes for the terminal.
    const red = '\u001b[31m';
    const reset = '\u001b[0m';

    var addedChars = 0;

    for (final mistake in result) {
      text = text.replaceRange(
        mistake.offset + addedChars,
        mistake.offset + mistake.length + addedChars,
        red +
            text.substring(
              mistake.offset + addedChars,
              mistake.offset + mistake.length + addedChars,
            ) +
            reset,
      );
      addedChars += 9;
    }

    print(text);
  }
}

class MistakeCard extends StatefulWidget {
  String issue = '';
  String issueType = '';
  List<String> possibleCorrections = [];

  MistakeCard({
    Key? key,
    required this.issue,
    required this.issueType,
    required this.possibleCorrections,
  }) : super(key: key);

  @override
  State<MistakeCard> createState() => _MistakeCardState();
}

class _MistakeCardState extends State<MistakeCard> {
  dynamic selectval;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: scheme.secondary,
          border: Border.all(
            width: 2.0,
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: ListTile(
              minVerticalPadding: 20,
              leading: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                radius: 12.0,
                child: Text(''),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  widget.issueType,
                  style: TextStyle(color: scheme.outline),
                ),
              ),
              title: Text(
                widget.issue,
                style: TextStyle(color: scheme.outline),
              ),
            ),
          ),
          DropdownButton<String>(
              iconDisabledColor: scheme.background,
              iconEnabledColor: scheme.background,
              value: selectval,
              hint: Text(
                'Possible Corrections',
                style: TextStyle(color: scheme.outline),
              ),
              items: widget.possibleCorrections.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectval = value;
                });
              }),
        ],
      ),
    );
  }
}
