import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedTexts extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final List<Shadow> shadows;

  const ModifiedTexts({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    this.shadows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.breeSerif(
        color: color,
        fontSize: size,
        shadows: shadows,
      ),
    );
  }
}
