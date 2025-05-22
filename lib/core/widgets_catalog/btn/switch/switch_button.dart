// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'switch_language_layout_mixin.dart';

class SCLanguageSwitchButton extends StatefulWidget {
  final Locale currentLocale;
  final List<Locale> localeList;
  final Color? textColor;
  final Color? fillColor;
  final Color? borderColor;
  final void Function(Locale)? onChangedLanguage;
  const SCLanguageSwitchButton({
    Key? key,
    required this.currentLocale,
    required this.localeList,
    this.textColor,
    this.fillColor,
    this.borderColor,
    this.onChangedLanguage,
  }) : super(key: key);

  @override
  State<SCLanguageSwitchButton> createState() => _SCLanguageSwitchButtonState();
}

class _SCLanguageSwitchButtonState extends State<SCLanguageSwitchButton>
    with SwitchLayoutMixin {
  late Locale _value;
  late List<Locale> _valueList;
  @override
  void initState() {
    _value = widget.currentLocale;
    _valueList = widget.localeList;
    super.initState();
  }

  @override
  void didUpdateWidget(SCLanguageSwitchButton oldWidget) {
    _value = widget.currentLocale;
    _valueList = widget.localeList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return mSwitchLayout<Locale>(
      value: _value,
      valuesList: _valueList,
      unSelectedTextColor: const Color(0xff977545),
      fillColor: const Color(0xff977545),
      borderColor: const Color(0xff977545),
      selectedTextColor: const Color(0XFFFFFFFF),
      unSelectedFillColor: const Color(0XFFFFFFFF),
      onChanged: (newVal) {
        widget.onChangedLanguage?.call(newVal);
        setState(() {
          _value = newVal;
        });
      },
    );
  }
}
