import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/constants/measurements.dart';
import 'package:developer_test/debug.dart';

enum TextTypes { body, header, small, banner, emphasis, button }

class KosyText extends StatelessWidget {
  final TextAlign textAlign;
  final bool bold;
  final TextTypes type;
  final double? height;
  final String body;

  final Color? color;

  static TextStyle relicTextStyles(
      double? size, FontWeight? fontWeight, Color? color) {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: Measurements.instance.getValue(size ?? 16),
      fontWeight: fontWeight,
      decoration: TextDecoration.none,
      color: color,
    ));
  }

  Color getDefaultColor(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = !kIsWeb && (brightness == Brightness.dark);

    return isDarkMode ? Colors.white : TextEmphasisColor;
  }

  KosyText(this.body,
      {this.textAlign = TextAlign.left,
      this.bold = false,
      this.type = TextTypes.body,
      Key? key,
      this.color,
      this.height})
      : super(key: key);

  TextStyle _generateTextStyle(BuildContext context) {
    Measurements measurements = Measurements.instance;
    double size = 0;
    switch (this.type) {
      case TextTypes.small:
        size = 12;
        break;
      case TextTypes.button:
      case TextTypes.emphasis:
        size = 14;
        break;
      case TextTypes.body:
        size = 16;
        break;
      case TextTypes.header:
        size = 20;
        break;
      case TextTypes.banner:
        size = 26;
        break;

      default:
        Debug.log("Undefined size '${this.type}' found \n ");
        size = 14;
        break;
    }

    return TextStyle(
        fontSize: measurements.getValue(size),
        fontWeight: (bold || size > 16)
            ? FontWeight.bold
            : (type == TextTypes.button)
                ? FontWeight.w700
                : FontWeight.normal,
        decoration: TextDecoration.none,
        color: this.color ?? getDefaultColor(context),
        height: height);
  }

  Widget build(BuildContext context) {
    TextStyle textStyle = _generateTextStyle(context);
    return Text(
      body,
      textDirection: TextDirection.ltr,
      style: GoogleFonts.lato(
        textStyle: textStyle,
      ),
      textAlign: this.textAlign,
    );
  }
}
