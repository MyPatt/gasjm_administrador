import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class InputText extends StatelessWidget {
  final String? initialValue;
  final bool autofocus;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusnode;
  final bool readOnly;
  final bool enabled;
  final TextEditingController? controller;
  final IconData? iconPrefix;
  final Color iconColor;
  final String? labelText;
  final bool filled;
  final Color fontColor;
  final double fontSize;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final InputBorder border;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;

  const InputText({
    Key? key,
    this.initialValue,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.focusnode,
    this.readOnly = false,
    this.enabled = true,
    this.controller,
    this.iconColor = AppTheme.light,
    this.labelText,
    this.filled = false,
    this.fontColor = Colors.black54,
    this.fontSize = 14.0,
    this.enabledBorderColor = Colors.black26,
    this.focusedBorderColor = AppTheme.blueBackground,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.hintText,
    this.minLines = 1,
    this.maxLines,
    this.border = InputBorder.none,
    this.textCapitalization,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.iconPrefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      initialValue: initialValue,
      style: TextStyle(color: fontColor, fontSize: fontSize),
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      decoration: InputDecoration(
          border: border,
          icon: Icon(
            iconPrefix,
            color: iconColor,
            size: 20.0,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black45),
          filled: filled,
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: enabledBorderColor,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: enabledBorderColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor,
            ),
          ),
          suffixIcon: suffixIcon,
          hintText: hintText,
          errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(
              width: .5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(
              width: .5,
              color: Colors.red,
            ),
          ),
          errorStyle: const TextStyle(color: Colors.red)),
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      //
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
    );
  }
}
