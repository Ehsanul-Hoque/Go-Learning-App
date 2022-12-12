import "package:app/app_config/resources.dart";
import "package:app/components/fields/app_input_base_widget.dart";
import "package:app/utils/typedefs.dart" show OnValueChangeListener;
import "package:app/utils/utils.dart";
import "package:flutter/material.dart" show TextFormField;
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

class AppInputField extends StatelessWidget implements AppInputBaseWidget {
  final OnValueChangeListener<String>? onChange;
  final FormFieldValidator<String>? validator;
  final String? label, hint;
  final double? borderRadius;
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
  final double? fontSize;
  final Color? textColor,
      cursorColor,
      hintOrLabelColor,
      errorColor,
      errorBorderColor,
      enabledBorderColor,
      focusedBorderColor;
  final Color? backgroundColor;
  final double? borderThickness,
      focusedBorderThickness,
      errorBorderThickness,
      focusedErrorBorderThickness;
  final bool noBorder, showCounterText;
  final FocusNode? focusNode;
  final TextStyle? counterTextStyle;
  final EdgeInsets? contentPadding;
  final bool enabled;

  const AppInputField({
    Key? key,
    this.onChange,
    this.validator,
    this.label,
    this.hint,
    this.borderRadius,
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
    this.fontSize,
    this.textColor,
    this.cursorColor,
    this.hintOrLabelColor,
    this.errorColor,
    this.errorBorderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.borderThickness,
    this.focusedBorderThickness,
    this.errorBorderThickness,
    this.focusedErrorBorderThickness,
    this.noBorder = false,
    this.showCounterText = true,
    this.focusNode,
    this.counterTextStyle,
    this.contentPadding,
    this.isCollapsed,
    this.isDense,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = this.fontSize ?? Res.dimen.fontSizeNormal;
    Color textColor = this.textColor ?? Res.color.textPrimary;
    Color cursorColor = this.cursorColor ?? Res.color.textPrimary;

    return TextFormField(
      enabled: enabled,
      readOnly: !enabled,
      expands: expands,
      style: Res.textStyles.general.copyWith(
        color: enabled ? textColor : Res.color.textTernary,
        fontSize: fontSize,
      ),
      keyboardType: textInputType ?? TextInputType.text,
      minLines: expands ? null : minLines,
      maxLines: expands ? null : maxLines,
      maxLength: maxLength > 0 ? maxLength : null,
      controller: textEditingController,
      autofocus: false,
      cursorColor: cursorColor,
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
        errorColor: errorColor,
        errorBorderColor: errorBorderColor,
        enabledBorderColor: enabledBorderColor,
        focusedBorderColor: focusedBorderColor,
        backgroundColor: backgroundColor,
        borderThickness: borderThickness,
        focusedBorderThickness: focusedBorderThickness,
        errorBorderThickness: errorBorderThickness,
        focusedErrorBorderThickness: focusedErrorBorderThickness,
        showCounterText: showCounterText,
        counterTextStyle: counterTextStyle,
        contentPadding: contentPadding,
        isCollapsed: isCollapsed,
        isDense: isDense,
        enabled: enabled,
      ),
    );
  }

  void onChanged(String value) {
    if (onChange != null) {
      onChange!(value);
    }
  }
}
