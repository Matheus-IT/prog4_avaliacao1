import 'package:flutter/material.dart';

import '../consts/typography.dart';

class RegularText extends StatelessWidget {
  final String content;
  final double fontSize;
  final bool withShadows; // Add shadows to text or not

  const RegularText({
    Key? key,
    required this.content,
    this.fontSize = 30.0,
    this.withShadows = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: 'LDFComicSans',
        fontSize: fontSize,
        shadows: withShadows ? kTextShadows : null,
      ),
    );
  }
}