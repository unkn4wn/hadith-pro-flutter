import 'package:flutter/material.dart';
import 'package:hadithpro/models/hadith.dart';

class HadithText extends StatelessWidget {
  final Hadith hadithText;
  final TextDirection textDirection;
  final TextStyle textStyle;
  const HadithText({
    Key? key,
    required this.hadithText,
    required this.textDirection,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      hadithText.text,
      softWrap: true,
      maxLines: null,
      textDirection: textDirection,
      textAlign: TextAlign.start,
      style: textStyle,
    );
  }
}

// style: GoogleFonts.notoKufiArabic(
//textStyle: const TextStyle(
//fontWeight: FontWeight.bold,
//height: 1.5,
//),
