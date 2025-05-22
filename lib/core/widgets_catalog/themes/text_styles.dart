import 'package:flutter/material.dart';

import 'colors.dart';

const tStyle = TextStyle(fontFamily: "Roboto");

extension AppTextStyle on TextStyle {
  // Colors
  TextStyle cTitle() => copyWith(color: Hcm23Colors.colorTextTitle);
  TextStyle cContent() => copyWith(color: Hcm23Colors.colorTextContent);
  TextStyle cPhuDe() => copyWith(color: Hcm23Colors.colorTextPhude);
  TextStyle cCustom(Color customColor) => copyWith(color: customColor);

  // Weights
  TextStyle w100() => copyWith(fontWeight: FontWeight.w100);
  TextStyle w300() => copyWith(fontWeight: FontWeight.w200);
  TextStyle w400() => copyWith(fontWeight: FontWeight.w300);
  TextStyle w500() => copyWith(fontWeight: FontWeight.w500);
  TextStyle w700() => copyWith(fontWeight: FontWeight.w700);
  TextStyle w900() => copyWith(fontWeight: FontWeight.w600);
  TextStyle wCustom(FontWeight customFontWeight) =>
      copyWith(fontWeight: customFontWeight);

  // Size
  TextStyle display24() => copyWith(fontSize: 24);
  TextStyle display22() => copyWith(fontSize: 22);
  TextStyle display20() => copyWith(fontSize: 20);
  TextStyle display18() => copyWith(fontSize: 18);
  TextStyle display16() => copyWith(fontSize: 16);
  TextStyle display14() => copyWith(fontSize: 14);
  TextStyle display13() => copyWith(fontSize: 13);
  TextStyle display12() => copyWith(fontSize: 12);
  TextStyle paragraph18() => copyWith(fontSize: 18, height: 30 / 18);
  TextStyle paragraph16() => copyWith(fontSize: 16, height: 26 / 16);
  TextStyle paragraph14() => copyWith(fontSize: 14, height: 22 / 14);
  TextStyle displayCustom(double customFontSize) =>
      copyWith(fontSize: customFontSize);
  TextStyle paragraphCustom(double customFontSize, double customHeight) =>
      copyWith(fontSize: customFontSize, height: customHeight);
}
