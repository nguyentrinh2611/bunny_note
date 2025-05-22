// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/text_styles.dart';
import '../input_normal/input_normal_layout_mixin.dart';

class InputClear extends StatefulWidget {
  final Widget? customLabel;

  final String? labelText;

  final TextStyle? labelTextStyle;

  final Widget? customHint;

  final String? hintText;

  final TextStyle? hintTextStyle;

  final Widget? customFeedback;

  final FeedbackType feedBackType;

  final String? feedbackMessage;

  final TextStyle? feedbackMessageStyle;

  final String? placeholderText;

  final TextStyle? placeholderTextStyle;

  final String? value;

  final TextStyle? valueTextStyle;

  final EdgeInsets? contentPadding;

  final bool? enable;

  final bool? viewOnly;

  final FocusNode? focusNode;

  final Color? fillColor;

  final TextEditingController? controller;

  final Color? cursorColor;

  final double? cursorHeight;

  final double? cursorWidth;

  final Function()? onUnfocus;

  final Function(String?)? onChanged;

  final TextInputType? keyboardType;

  final TextCapitalization? textCapitalization;

  final TextInputAction? textInputAction;

  final StrutStyle? strutStyle;

  final TextDirection? textDirection;

  final TextAlign? textAlign;

  final TextAlignVertical? textAlignVertical;

  final bool? autofocus;

  final ToolbarOptions? toolbarOptions;

  final bool? showCursor;

  final String? obscuringCharacter;

  final bool? obscureText;

  final bool? autocorrect;

  final SmartDashesType? smartDashesType;

  final SmartQuotesType? smartQuotesType;

  final bool? enableSuggestions;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final int? maxLines;

  final int? minLines;

  final bool? expands;

  final int? maxLength;

  final void Function()? onTap;

  final void Function()? onEditingComplete;

  final void Function(String?)? onFieldSubmitted;

  final void Function(String?)? onSaved;

  final List<TextInputFormatter>? inputFormatters;

  final Radius? cursorRadius;

  final Brightness? keyboardAppearance;

  final EdgeInsets? scrollPadding;

  final bool? enableInteractiveSelection;

  final TextSelectionControls? selectionControls;

  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;

  final ScrollPhysics? scrollPhysics;

  final Iterable<String>? autofillHints;

  final AutovalidateMode? autovalidateMode;

  final String? restorationId;

  final bool? enableIMEPersonalizedLearning;

  final MouseCursor? mouseCursor;

  final InputDecoration? decoration;

  final Widget clearButton;
  const InputClear({
    Key? key,
    this.customLabel,
    this.labelText,
    this.labelTextStyle,
    this.customHint,
    this.hintText,
    this.hintTextStyle,
    this.customFeedback,
    this.feedBackType = FeedbackType.none,
    this.feedbackMessage,
    this.feedbackMessageStyle,
    this.placeholderText,
    this.placeholderTextStyle,
    this.value,
    this.valueTextStyle,
    this.contentPadding,
    this.enable,
    this.viewOnly,
    this.focusNode,
    this.fillColor,
    this.controller,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth,
    this.onUnfocus,
    this.onChanged,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.autofocus,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions,
    this.maxLengthEnforcement,
    this.maxLines,
    this.minLines,
    this.expands,
    this.maxLength,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.cursorRadius,
    this.keyboardAppearance,
    this.scrollPadding,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.restorationId,
    this.enableIMEPersonalizedLearning,
    this.mouseCursor,
    this.decoration,
    this.buildCounter,
    required this.clearButton,
  }) : super(key: key);

  @override
  State<InputClear> createState() => _InputClearState();
}

class _InputClearState extends State<InputClear> with InputNormalLayoutMixin {
  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildLayout(context);
  }

  Widget buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (controller?.text != null && controller!.text.isNotEmpty)
          InkWell(
            onTap: () {
              setState(() {
                controller?.clear();
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: widget.clearButton,
            ),
          ),
        decoration?.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: decoration?.suffixIcon,
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Widget buildTextFormField() {
    return TextFormField(
      controller: controller,
      initialValue: value,
      focusNode: focusNode,
      style: valueTextStyle ??
          (obscureText == true
              ? tStyle.display16().w900().cTitle()
              : tStyle.display14().w400().cTitle()),
      onChanged: onChanged,
      enabled: enable,
      readOnly: viewOnly == true,
      cursorColor: cursorColor ?? const Color(0XFF000000),
      cursorHeight: cursorHeight ?? 14,
      cursorWidth: cursorWidth ?? 1.0,
      decoration: decoration?.copyWith(
        fillColor: fillColor ?? const Color(0XDDDBDFEF).withOpacity(0.2),
        filled: buildFilled(),
        enabled: enable,
        isCollapsed: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
        hintText: placeholderText,
        hintStyle: placeholderTextStyle ??
            tStyle.display14().w400().copyWith(
                  color: const Color(0XFF586B8B).withOpacity(0.5),
                ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        disabledBorder: buildBorder(),
        suffixIcon: buildSuffixIcon(),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction: textInputAction,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      autofocus: autofocus ?? false,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter ?? '•',
      obscureText: obscureText ?? false,
      autocorrect: autocorrect ?? true,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions ?? true,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: obscureText == true ? 1 : maxLines,
      minLines: minLines,
      expands: expands ?? false,
      maxLength: maxLength,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      cursorRadius: cursorRadius,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      buildCounter: buildCounter,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      restorationId: restorationId,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning ?? true,
      mouseCursor: mouseCursor,
    );
  }

  @override
  bool? get autocorrect => widget.autocorrect;

  @override
  Iterable<String>? get autofillHints => widget.autofillHints;

  @override
  bool? get autofocus => widget.autofocus;

  @override
  AutovalidateMode? get autovalidateMode => widget.autovalidateMode;

  @override
  Widget? Function(BuildContext p1,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? get buildCounter => widget.buildCounter;

  @override
  EdgeInsets? get contentPadding => widget.contentPadding;

  @override
  TextEditingController? get controller => widget.controller;

  @override
  Color? get cursorColor => widget.cursorColor;

  @override
  double? get cursorHeight => widget.cursorHeight;

  @override
  Radius? get cursorRadius => widget.cursorRadius;

  @override
  double? get cursorWidth => widget.cursorWidth;

  @override
  Widget? get customFeedback => widget.customFeedback;

  @override
  Widget? get customHint => widget.customHint;

  @override
  Widget? get customLabel => widget.customLabel;

  @override
  InputDecoration? get decoration => widget.decoration;

  @override
  bool? get enable => widget.enable;

  @override
  bool? get enableIMEPersonalizedLearning =>
      widget.enableIMEPersonalizedLearning;

  @override
  bool? get enableInteractiveSelection => widget.enableInteractiveSelection;

  @override
  bool? get enableSuggestions => widget.enableSuggestions;

  @override
  bool? get expands => widget.expands;

  @override
  String? get feedbackMessage => widget.feedbackMessage;

  @override
  TextStyle? get feedbackMessageStyle => widget.feedbackMessageStyle;

  @override
  Color? get fillColor => widget.fillColor;

  @override
  FocusNode? get focusNode => widget.focusNode;

  @override
  String? get hintText => widget.hintText;

  @override
  TextStyle? get hintTextStyle => widget.hintTextStyle;

  @override
  List<TextInputFormatter>? get inputFormatters => widget.inputFormatters;

  @override
  Brightness? get keyboardAppearance => widget.keyboardAppearance;

  @override
  TextInputType? get keyboardType => widget.keyboardType;

  @override
  String? get labelText => widget.labelText;

  @override
  TextStyle? get labelTextStyle => widget.labelTextStyle;

  @override
  int? get maxLength => widget.maxLength;

  @override
  MaxLengthEnforcement? get maxLengthEnforcement => widget.maxLengthEnforcement;

  @override
  int? get maxLines => widget.maxLines;

  @override
  int? get minLines => widget.minLines;

  @override
  MouseCursor? get mouseCursor => widget.mouseCursor;

  @override
  bool? get obscureText => widget.obscureText;

  @override
  String? get obscuringCharacter => widget.obscuringCharacter;

  @override
  Function(String? p1)? get onChanged => widget.onChanged;

  @override
  void Function()? get onEditingComplete => widget.onEditingComplete;

  @override
  void Function(String? p1)? get onFieldSubmitted => widget.onFieldSubmitted;

  @override
  void Function(String? p1)? get onSaved => widget.onSaved;

  @override
  void Function()? get onTap => widget.onTap;

  @override
  Function()? get onUnfocus => widget.onUnfocus;

  @override
  String? get placeholderText => widget.placeholderText;

  @override
  TextStyle? get placeholderTextStyle => widget.placeholderTextStyle;

  @override
  String? get restorationId => widget.restorationId;

  @override
  EdgeInsets? get scrollPadding => widget.scrollPadding;

  @override
  ScrollPhysics? get scrollPhysics => widget.scrollPhysics;

  @override
  TextSelectionControls? get selectionControls => widget.selectionControls;

  @override
  bool? get showCursor => widget.showCursor;

  @override
  SmartDashesType? get smartDashesType => widget.smartDashesType;

  @override
  SmartQuotesType? get smartQuotesType => widget.smartQuotesType;

  @override
  StrutStyle? get strutStyle => widget.strutStyle;

  @override
  TextAlign? get textAlign => widget.textAlign;

  @override
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;

  @override
  TextCapitalization? get textCapitalization => widget.textCapitalization;

  @override
  TextDirection? get textDirection => widget.textDirection;

  @override
  TextInputAction? get textInputAction => widget.textInputAction;

  @override
  ToolbarOptions? get toolbarOptions => widget.toolbarOptions;

  @override
  String? get value => widget.value;

  @override
  TextStyle? get valueTextStyle => widget.valueTextStyle;

  @override
  bool? get viewOnly => widget.viewOnly;

  @override
  FeedbackType get feedBackType => widget.feedBackType;
}
