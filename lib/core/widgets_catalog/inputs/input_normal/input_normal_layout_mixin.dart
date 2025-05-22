import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/text_styles.dart';

mixin InputNormalLayoutMixin {
  Widget buildLayout(
    BuildContext context,
  ) {
    return Column(
      children: [
        buildLabelAndHint(),
        buildTextFormField(),
        buildFeedback(),
      ],
    );
  }

  /// buildLabelAndHint
  Widget buildLabelAndHint() {
    return (customLabel != null ||
            labelText != null ||
            customHint != null ||
            hintText != null)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: customLabel ??
                      Text(
                        labelText ?? "",
                        style: labelTextStyle ??
                            tStyle.display14().w400().copyWith(
                                  color: const Color(0XFF586B8B),
                                ),
                        overflow: TextOverflow.fade,
                      ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: customHint ??
                      Text(
                        hintText ?? "",
                        style: hintTextStyle ??
                            tStyle.w400().copyWith(
                                  fontSize: 12,
                                  color: const Color(0XFF586B8B),
                                ),
                        overflow: TextOverflow.fade,
                      ),
                ),
              )
            ],
          )
        : const SizedBox();
  }

  /// buildFeedback
  Widget buildFeedback() {
    return Container(
      margin: feedBackType != FeedbackType.none
          ? const EdgeInsets.only(top: 8, bottom: 16)
          : const EdgeInsets.only(top: 16),
      child: customFeedback ??
          (feedBackType != FeedbackType.none
              ? Row(
                  children: [
                    buildFeedbackIcon(),
                    Text(
                      feedbackMessage ?? "",
                      style: feedbackMessageStyle ??
                          tStyle.w400().copyWith(
                                fontSize: 12,
                                color: const Color(0XFF586B8B),
                              ),
                      overflow: TextOverflow.fade,
                    )
                  ],
                )
              : const SizedBox.shrink()),
    );
  }

  Widget buildFeedbackIcon() {
    switch (feedBackType) {
      case FeedbackType.error:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          color: const Color(0XFFEA5455),
          // child: SvgPicture.asset(
          //   "packages/hcm23ui/assets/icons/bold/error.svg",
          //   fit: BoxFit.scaleDown,
          // ),
        );
      case FeedbackType.warning:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          color: const Color(0XFFF3AA1C),
          // child: SvgPicture.asset(
          //   "packages/hcm23ui/assets/icons/bold/danger.svg",
          //   fit: BoxFit.scaleDown,
          // ),
        );
      case FeedbackType.success:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          color: Colors.green,
          // child: SvgPicture.asset(
          //   "packages/hcm23ui/assets/icons/bold/ticksquare.svg",
          //   fit: BoxFit.scaleDown,
          // ),
        );
      case FeedbackType.none:
      default:
        return const SizedBox.shrink();
    }
  }

  // ==================================================================

  /// buildTextFormField
  Widget buildTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: TextFormField(
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
        cursorHeight: cursorHeight ?? valueTextStyle?.height,
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
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    late Color borderColor;
    double opacity =
        !(enable == true) ? 0.5 : (focusNode?.hasFocus == true ? 0.5 : 1);

    switch (feedBackType) {
      case FeedbackType.warning:
        borderColor = const Color(0XFFF3AA1C).withOpacity(opacity);

        break;
      case FeedbackType.error:
        borderColor = const Color(0XFFEA5455).withOpacity(opacity);

        break;
      case FeedbackType.success:
        borderColor = const Color(0XFF7966FF).withOpacity(opacity);

        break;
      case FeedbackType.none:
      default:
        borderColor = const Color(0XFFDBDFEF);
        break;
    }
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }

  buildPlaceholderTextStyle() {
    return tStyle.display14().w400().copyWith(
          color: const Color(0XFF586B8B).withOpacity(0.5),
        );
  }

  buildValueTextStyle() {
    return tStyle.display14().w400().copyWith(
          color: const Color(0XFF3D5586),
        );
  }

  bool buildFilled() {
    if (feedBackType == FeedbackType.none &&
        (!(enable == true) || (viewOnly == true))) {
      return true;
    }
    return false;
  }

  Widget? get customLabel;
  String? get labelText;
  TextStyle? get labelTextStyle;
  Widget? get customHint;
  String? get hintText;
  TextStyle? get hintTextStyle;
  Widget? get customFeedback;
  FeedbackType get feedBackType;
  String? get feedbackMessage;
  TextStyle? get feedbackMessageStyle;
  String? get placeholderText;
  TextStyle? get placeholderTextStyle;
  String? get value;
  TextStyle? get valueTextStyle;
  EdgeInsets? get contentPadding;
  bool? get enable;
  bool? get viewOnly;
  FocusNode? get focusNode;
  Color? get fillColor;
  TextEditingController? get controller;
  Color? get cursorColor;
  double? get cursorHeight;
  double? get cursorWidth;
  Function()? get onUnfocus;
  Function(String?)? get onChanged;
  TextInputType? get keyboardType;
  TextCapitalization? get textCapitalization;
  TextInputAction? get textInputAction;
  StrutStyle? get strutStyle;
  TextDirection? get textDirection;
  TextAlign? get textAlign;
  TextAlignVertical? get textAlignVertical;
  bool? get autofocus;
  ToolbarOptions? get toolbarOptions;
  bool? get showCursor;
  String? get obscuringCharacter;
  bool? get obscureText;
  bool? get autocorrect;
  SmartDashesType? get smartDashesType;
  SmartQuotesType? get smartQuotesType;

  bool? get enableSuggestions;
  MaxLengthEnforcement? get maxLengthEnforcement;
  int? get maxLines;
  int? get minLines;
  bool? get expands;
  int? get maxLength;
  void Function()? get onTap;
  void Function()? get onEditingComplete;
  void Function(String?)? get onFieldSubmitted;
  void Function(String?)? get onSaved;
  List<TextInputFormatter>? get inputFormatters;
  Radius? get cursorRadius;
  Brightness? get keyboardAppearance;
  EdgeInsets? get scrollPadding;
  bool? get enableInteractiveSelection;
  TextSelectionControls? get selectionControls;
  Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? get buildCounter;
  ScrollPhysics? get scrollPhysics;
  Iterable<String>? get autofillHints;
  AutovalidateMode? get autovalidateMode;
  String? get restorationId;
  bool? get enableIMEPersonalizedLearning;
  MouseCursor? get mouseCursor;
  InputDecoration? get decoration;
}

enum FeedbackType {
  error,
  warning,
  success,
  none,
}
