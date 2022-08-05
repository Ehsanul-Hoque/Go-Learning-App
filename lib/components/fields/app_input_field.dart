import "package:app/app_config/default_parameters.dart";
import "package:app/utils/app_colors.dart";
import "package:app/utils/utils.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

typedef OnChangeListener = void Function(String value);

class AppInputField extends StatelessWidget {
  final OnChangeListener? onChange;
  final FormFieldValidator<String>? validator;
  final String? label, hint;
  final double borderRadius;
  final bool goNextOnComplete, obscureText;
  final bool? isCollapsed, isDense;
  final String? prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final BoxConstraints? prefixIconConstraints, suffixIconConstraints;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool expands;
  final Color textColor,
      cursorColor,
      hintOrLabelColor,
      enabledBorderColor,
      focusedBorderColor;
  final Color? backgroundColor;
  final bool noBorder, showCounterText;
  final FocusNode? focusNode;
  final TextStyle? counterTextStyle;
  final EdgeInsets? contentPadding;

  const AppInputField({
    Key? key,
    this.onChange,
    this.validator,
    this.label,
    this.hint,
    this.borderRadius = DefaultParameters.defaultBorderRadiusValue,
    this.prefixText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixText,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.textEditingController,
    this.goNextOnComplete = false,
    this.textInputType,
    this.inputFormatters,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 1000,
    this.expands = false,
    this.obscureText = false,
    Color? textColor,
    Color? cursorColor,
    Color? hintOrLabelColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    this.backgroundColor,
    this.noBorder = false,
    this.showCounterText = true,
    this.focusNode,
    this.counterTextStyle,
    this.contentPadding,
    this.isCollapsed,
    this.isDense,
  })  : textColor = textColor ?? AppColors.black,
        cursorColor = cursorColor ?? AppColors.black,
        hintOrLabelColor = hintOrLabelColor ?? AppColors.grey600,
        enabledBorderColor = enabledBorderColor ?? AppColors.grey300,
        focusedBorderColor = focusedBorderColor ?? AppColors.grey600,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      style: DefaultParameters.defaultTextStyle.copyWith(
        color: textColor,
      ),
      keyboardType: textInputType ?? TextInputType.text,
      minLines: expands ? null : minLines,
      maxLines: expands ? null : maxLines,
      maxLength: maxLength > 0 ? maxLength : null,
      controller: textEditingController,
      autofocus: false,
      cursorColor: textColor,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      textInputAction: (maxLines > 1 ||
              textInputType == TextInputType.multiline)
          ? TextInputAction.newline
          : (goNextOnComplete ? TextInputAction.next : TextInputAction.done),
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.top,
      decoration: Utils.getAppInputDecoration(
        hint: hint,
        label: label,
        borderRadius: borderRadius,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        hintOrLabelColor: hintOrLabelColor,
        enabledBorderColor: enabledBorderColor,
        focusedBorderColor: focusedBorderColor,
        backgroundColor: backgroundColor,
        showCounterText: showCounterText,
        counterTextStyle: counterTextStyle,
        contentPadding: contentPadding,
        isCollapsed: isCollapsed,
        isDense: isDense,
      ),
    );
  }

  void onChanged(String value) {
    if (onChange != null) {
      onChange!(value);
    }
  }
}
