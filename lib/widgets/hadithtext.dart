import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/hadith.dart';

class HadithText extends StatelessWidget {
  final Hadith hadithText;
  final TextDirection;
  final String fontFamily;
  final FontWeight;
  const HadithText({
    Key? key,
    required this.hadithText,
    required this.TextDirection,
    required this.fontFamily,
    required this.FontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      hadithText.text,
      softWrap: true,
      maxLines: null,
      textDirection: TextDirection,
      textAlign: TextAlign.start,
      style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight),
    );
  }
}

// style: GoogleFonts.notoKufiArabic(
//textStyle: const TextStyle(
//fontWeight: FontWeight.bold,
//height: 1.5,
//),
