import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

mixin SwitchLayoutMixin {
  Widget rollingLanguageBuilder<T>(
    T value,
    Size iconSize,
    Color textColor,
    Color unSlectedFillColor,
  ) {
    String language = 'vi';
    if (value is Locale) language = value.languageCode;
    TextStyle textStyleLanguageApp = TextStyle(
      fontSize: 12,
      color: textColor,
      fontWeight: FontWeight.w600,
    );

    return Container(
      color: unSlectedFillColor,
      child: Center(
        child: Text(
          language.toUpperCase(),
          style: textStyleLanguageApp,
        ),
      ),
    );
  }

  Widget showLanguageWidget<T>(
    T valueObj,
    int value,
    Size iconSize,
    Color textColor,
  ) {
    String language = "vi";
    if (valueObj is Locale) language = valueObj.languageCode;
    TextStyle textStyleLanguageApp = TextStyle(
      fontSize: 12,
      color: textColor,
      fontWeight: FontWeight.w600,
    );

    return Center(
      child: Text(
        language.toUpperCase(),
        style: textStyleLanguageApp,
      ),
    );
  }

  Transform foregroundIndicatorIconBuilder<T>(
    BuildContext context,
    DetailedGlobalToggleProperties<T> global,
    Color textColor,
    List<T> valuesObj,
  ) {
    double pos = global.position;
    double transitionValue = pos - pos.floorToDouble();

    return Transform.rotate(
      angle: 2.0 * pi * transitionValue,
      child: Stack(
        children: [
          Opacity(
            opacity: 1 - transitionValue,
            child: showLanguageWidget<T>(
              valuesObj[pos.floor()],
              pos.floor(),
              global.indicatorSize,
              textColor,
            ),
          ),
          Opacity(
            opacity: transitionValue,
            child: showLanguageWidget<T>(
              valuesObj[pos.ceil()],
              pos.ceil(),
              global.indicatorSize,
              textColor,
            ),
          )
        ],
      ),
    );
  }

  Widget mSwitchLayout<T>({
    required T value,
    required List<T> valuesList,
    required void Function(T)? onChanged,
    required Color unSelectedTextColor,
    required Color selectedTextColor,
    required Color fillColor,
    required Color borderColor,
    required Color unSelectedFillColor,
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height ?? 30,
      width: width ?? 80,
      child: AnimatedToggleSwitch<T>.size(
        current: value,
        values: valuesList,
        iconOpacity: 1.0,
        foregroundIndicatorIconBuilder: (context, global) {
          return foregroundIndicatorIconBuilder<T>(
            context,
            global,
            selectedTextColor,
            valuesList,
          );
        },
        selectedIconSize: const Size.square(20),
        iconSize: const Size.square(20),
        iconBuilder: (i, s) => rollingLanguageBuilder<T>(
          i,
          s,
          unSelectedTextColor,
          Colors.transparent,
        ),
        colorBuilder: (i) => fillColor,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(20.0),
        indicatorBorderRadius: BorderRadius.zero,
        borderColor: borderColor,
      ),
    );
  }
}
