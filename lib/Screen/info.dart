import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var scheme = Theme.of(context).colorScheme;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: width-40,
                  height: height *0.45,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),  color: scheme.primary, border: Border.fromBorderSide(BorderSide(width: 3, color: scheme.secondary))),
                  child: ListView(
                    children: [
                      Icon(Icons.info_outline_rounded, color: scheme.surfaceTint, size: width/8,),
                      const SizedBox(height: 20,),
                      AutoSizeText(
                        "WriteRight is a grammar and spell check application, created by Ayaan Rege, that aims to give 'pen-and-paper' inclined writers the same writing capabilities as they would have on high-end word processing software. After following only 3 simple steps, each user can easily and efficiently get real-time feedback on their handwritten text.",
                        style: TextStyle(
                            color: scheme.outline, ),
                        minFontSize: 18.0,
                        maxLines: 11,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(color: scheme.surfaceTint, thickness: 3, ),
            ),
            const SizedBox(height: 20,),
            AutoSizeText(
              "FAQ's",
              style: TextStyle(
                  color: scheme.outlineVariant, fontWeight: FontWeight.w700),
              minFontSize: 36.0,
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: scheme.secondary),
                  borderRadius: BorderRadius.circular(5.0)),
              collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    color: scheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              iconColor: scheme.surfaceTint,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              collapsedBackgroundColor: scheme.primary,
              backgroundColor: scheme.primary,
              title: AutoSizeText(
                "Does the grammar check work with different languages?",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: scheme.outlineVariant),
                maxLines: 2,
              ),
              children: [
                Container(
                  width: width - 40,
                  height: height * 0.125,
                  color: scheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: AutoSizeText(
                      "Yes! Our machine learning model is capable of analyzing a wide variety of diverse languages!",
                      style: TextStyle(color: scheme.outlineVariant),
                      maxLines: 5,
                      minFontSize: 16,
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: scheme.secondary),
                  borderRadius: BorderRadius.circular(5.0)),
              collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    color: scheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              iconColor: scheme.surfaceTint,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              collapsedBackgroundColor: scheme.primary,
              backgroundColor: scheme.primary,
              title: AutoSizeText(
                "Why isn't the grammar check working?",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: scheme.outlineVariant),
                maxLines: 2,
              ),
              children: [
                Container(
                  width: width - 40,
                  height: height * 0.3,
                  color: scheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: AutoSizeText(
                      "There could be a number of reasons why our grammar check isn't performing how you expected. The most common include: you have not given enough context/information (your text is too short to be efficiently analyzed) , your text doesn't contain any errors in the first place, or you are not connected to the internet. If your text is free of these issues but you are still noticing issues, we apologize, and we assure you that we are working hard to fix any bugs and improve your experience.",
                      style: TextStyle(color: scheme.outlineVariant),
                      maxLines: 14,
                      minFontSize: 16,
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: scheme.secondary),
                  borderRadius: BorderRadius.circular(5.0)),
              collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    color: scheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              iconColor: scheme.surfaceTint,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              collapsedBackgroundColor: scheme.primary,
              backgroundColor: scheme.primary,
              title: AutoSizeText(
                "Is there a way where I can get more information about my mistakes?",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: scheme.outlineVariant),
                maxLines: 2,
              ),
              children: [
                Container(
                  width: width - 40,
                  height: height * 0.17,
                  color: scheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: AutoSizeText(
                      "Yes! With most errors in your grammar checks, you can tap on the popups, which will bring you to an information page! The page will: explain your error, give examples of that error, and even give advice on how to avoid the error in the future!",
                      style: TextStyle(color: scheme.outlineVariant),
                      maxLines: 14,
                      minFontSize: 16,
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: scheme.secondary),
                  borderRadius: BorderRadius.circular(5.0)),
              collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    color: scheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              iconColor: scheme.surfaceTint,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              collapsedBackgroundColor: scheme.primary,
              backgroundColor: scheme.primary,
              title: AutoSizeText(
                "Is WriteRight allowed in my school/institution?",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: scheme.outlineVariant),
                maxLines: 2,
              ),
              children: [
                Container(
                  width: width - 40,
                  height: height * 0.16,
                  color: scheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: AutoSizeText(
                      "While we have designed WriteRight with the goal of being utilized in educational settings, it is always best to check with a teacher or faculty member whether WriteRight is permitted within your own school/institution.",
                      style: TextStyle(color: scheme.outlineVariant),
                      maxLines: 14,
                      minFontSize: 16,
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // AutoSizeText(
            //   "User Preferences",
            //   style: TextStyle(
            //       color: scheme.outlineVariant, fontWeight: FontWeight.w700),
            //   minFontSize: 36.0,
            //   maxLines: 1,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            AutoSizeText(
              "Credits",
              style: TextStyle(
                  color: scheme.outlineVariant, fontWeight: FontWeight.w700),
              minFontSize: 36.0,
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            AutoSizeText(
              "Special thanks to my English teacher Mrs. Neese, who challenged me to change the world, and supported me through the entirety of this project.",
              style: TextStyle(
                  color: scheme.outlineVariant,),
              minFontSize: 18.0,
              maxLines: 6,
            ),
            const SizedBox(
              height: 20,
            ),
            AutoSizeText(
              "Image Credits:",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.outlineVariant,),
              minFontSize: 15.0,
              maxLines: 6,
            ),
            const SizedBox(
              height: 10,
            ),
            AutoSizeText(
              "https://www.freepik.com/free-vector/man-signing-contract-with-big-pen_11235712.htm",
              style: TextStyle(
                color: scheme.outlineVariant,),
              minFontSize: 15.0,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}
