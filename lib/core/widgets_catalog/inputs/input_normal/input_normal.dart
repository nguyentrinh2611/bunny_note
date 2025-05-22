// ignoreforfile: publicmemberapidocs, sortconstructorsfirst
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_normal_layout_mixin.dart';

class InputNormal extends StatelessWidget with InputNormalLayoutMixin {
  @override
  final Widget? customLabel;
  @override
  final String? labelText;
  @override
  final TextStyle? labelTextStyle;
  @override
  final Widget? customHint;
  @override
  final String? hintText;
  @override
  final TextStyle? hintTextStyle;
  @override
  final Widget? customFeedback;
  @override
  final FeedbackType feedBackType;
  @override
  final String? feedbackMessage;
  @override
  final TextStyle? feedbackMessageStyle;
  @override
  final String? placeholderText;
  @override
  final TextStyle? placeholderTextStyle;
  @override
  final String? value;
  @override
  final TextStyle? valueTextStyle;
  @override
  final EdgeInsets? contentPadding;
  @override
  final bool? enable;
  @override
  final bool? viewOnly;
  @override
  final FocusNode? focusNode;
  @override
  final Color? fillColor;
  @override
  final TextEditingController? controller;
  @override
  final Color? cursorColor;
  @override
  final double? cursorHeight;
  @override
  final double? cursorWidth;
  @override
  final Function()? onUnfocus;
  @override
  final Function(String?)? onChanged;
  @override
  final TextInputType? keyboardType;
  @override
  final TextCapitalization? textCapitalization;
  @override
  final TextInputAction? textInputAction;
  @override
  final StrutStyle? strutStyle;
  @override
  final TextDirection? textDirection;
  @override
  final TextAlign? textAlign;
  @override
  final TextAlignVertical? textAlignVertical;
  @override
  final bool? autofocus;
  @override
  final ToolbarOptions? toolbarOptions;
  @override
  final bool? showCursor;
  @override
  final String? obscuringCharacter;
  @override
  final bool? obscureText;
  @override
  final bool? autocorrect;
  @override
  final SmartDashesType? smartDashesType;
  @override
  final SmartQuotesType? smartQuotesType;
  @override
  final bool? enableSuggestions;
  @override
  final MaxLengthEnforcement? maxLengthEnforcement;
  @override
  final int? maxLines;
  @override
  final int? minLines;
  @override
  final bool? expands;
  @override
  final int? maxLength;
  @override
  final void Function()? onTap;
  @override
  final void Function()? onEditingComplete;
  @override
  final void Function(String?)? onFieldSubmitted;
  @override
  final void Function(String?)? onSaved;
  @override
  final List<TextInputFormatter>? inputFormatters;
  @override
  final Radius? cursorRadius;
  @override
  final Brightness? keyboardAppearance;
  @override
  final EdgeInsets? scrollPadding;
  @override
  final bool? enableInteractiveSelection;
  @override
  final TextSelectionControls? selectionControls;
  @override
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;
  @override
  final ScrollPhysics? scrollPhysics;
  @override
  final Iterable<String>? autofillHints;
  @override
  final AutovalidateMode? autovalidateMode;
  @override
  final String? restorationId;
  @override
  final bool? enableIMEPersonalizedLearning;
  @override
  final MouseCursor? mouseCursor;
  @override
  final InputDecoration? decoration;
  const InputNormal({
    super.key,
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
  })  : assert(
            customLabel == null ||
                (labelText == null && labelTextStyle == null),
            "\n =>Only use customLabel (Widget) or labelText(String)"),
        assert(
            ((feedBackType != FeedbackType.none && feedbackMessage != null) ||
                (feedBackType == FeedbackType.none &&
                    feedbackMessage == null &&
                    feedbackMessageStyle == null)),
            "\n => When feedBackType == FeedbackType.none, feedbackMessage == null and feedbackMessageStyle == null"),
        assert(value == null || controller == null);
  @override
  Widget build(BuildContext context) {
    return buildLayout(context);
  }
}
