import 'package:flutter/material.dart';
import 'package:hadithpro/models/hadith.dart';

class HadithText extends StatelessWidget {
  final Hadith hadithText;
  final TextDirection;
  final TextStyle;
  const HadithText({
    Key? key,
    required this.hadithText,
    required this.TextDirection,
    required this.TextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      hadithText.text,
      softWrap: true,
      maxLines: null,
      textDirection: TextDirection,
      textAlign: TextAlign.start,
      style: TextStyle,
    );
  }
}

// style: GoogleFonts.notoKufiArabic(
//textStyle: const TextStyle(
//fontWeight: FontWeight.bold,
//height: 1.5,
//),
