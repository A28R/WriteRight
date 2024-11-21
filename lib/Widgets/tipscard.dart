import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
class TipsCard extends StatelessWidget {
  final String header;
  final String text;
  final IconData icon;

  const TipsCard({Key? key, required this.text, required this.icon, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: width - 40,
      height: height * 0.4,
      decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: scheme.secondary, width: 5.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AutoSizeText(
            header,
            style: TextStyle(color: scheme.outline, fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),

          Icon(
            icon,
            color: scheme.surfaceTint,
            size: height * 0.25,
          ),

          AutoSizeText(
            text,
            style: TextStyle(color: scheme.outline, fontSize: 20),
            textAlign: TextAlign.center,
            maxLines: 4,
          )
        ],
      ),
    );
  }
}
