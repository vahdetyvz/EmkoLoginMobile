import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLines;
  final double? minFontSize, maxFontSize;
  final TextAlign? align;
  final String fontFamily;

  const CustomText(
      {super.key,
      required this.text,
      this.style,
      this.maxLines,
      this.maxFontSize,
      this.minFontSize,
      this.align,
      this.fontFamily = "Roboto"});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text ?? "",
      minFontSize: minFontSize ?? 1,
      maxLines: maxLines ?? 1,
      maxFontSize: maxFontSize ?? 56,
      textAlign: align,
      style: GoogleFonts.inter(
        textStyle: style != null
            ? style?.copyWith(
                fontFamily: fontFamily,
              )
            : TextStyle(
                color: Colors.white,
                fontFamily: fontFamily,
              ),
      ),
    );
  }
}
