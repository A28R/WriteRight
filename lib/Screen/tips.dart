
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

import 'package:ocr/Widgets/tipscard.dart';
import 'package:ocr/themes/light_theme.dart';
import 'package:ocr/themes/dark_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TipsPage extends StatelessWidget {
  final _controller = PageController();

  TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.6,
            width: width - 40,
            child: PageView(


              controller: _controller,
              children: const [
                TipsCard(text: "Swipe for some tips to get better, more accurate scans!", icon: Icons.tips_and_updates_rounded, header: 'Scanning Tips'),
                TipsCard(icon: CupertinoIcons.lightbulb_fill, text: "When scanning your text, ensure that your paper is well lit and doesn't contain any shadows.", header: 'Proper Lighting',),
                TipsCard(icon: CupertinoIcons.pencil, text: "When scanning your text, ensure that your handwriting is neat and legible. (If using lined paper, make sure to write within the lines)" ,header: 'Neat Handwriting',),
                TipsCard(icon: CupertinoIcons.hand_raised_slash_fill, text:  'When scanning your text, hold the camera steady, and ensure that the paper is within focus.',header: 'Steady Camera',),
                TipsCard(icon: LineIcons.rulerVertical, text: 'When scanning your text, ensure that your device is around 8-10 inches(20.32-25.4 cm) above your paper, and centered above the text.',header: 'Maintain Distance',),


              ],


            ),
          ),
          SmoothPageIndicator(controller: _controller, count: 5, effect: SwapEffect(
            activeDotColor: scheme.surfaceTint,
            dotColor: scheme.secondary
          ),),
        ],
      ),
    );
  }
}
