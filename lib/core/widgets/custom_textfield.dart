import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.context,
    this.labelText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.autovalidateMode,
    this.focusNode,
    this.inputTextStyle,
    this.obscureText = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.focusedBorderSideColor,
    this.autoFocus = false,
    this.focusedErrorBorder,
    this.errorBorder,
    this.focusBorder,
    this.prefixText,
    this.prefixTextStyle,
    this.isEnabled = true,
    this.cursorHeight,
    this.cursorColor,
    this.borderRadiusValue,
    this.borderRadius,
    this.hintText,
    this.showCursor,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.autofillHints,
    this.textCapitalization,
  }) : super(key: key);

  final BuildContext context;
  final String? labelText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final TextStyle? inputTextStyle;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final Function(String?)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Color? focusedBorderSideColor;
  final bool autoFocus;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusBorder;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final bool isEnabled;
  final double? cursorHeight;
  final Color? cursorColor;
  final double? borderRadiusValue;
  final double? borderRadius;
  final String? hintText;
  final bool? showCursor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final Iterable<String>? autofillHints;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      showCursor: showCursor,
      enabled: isEnabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText,
      style: inputTextStyle ?? Theme.of(context).textTheme.bodyText2,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
      cursorColor: AppColors.blackColor,
      cursorHeight: cursorHeight ?? 22,
      cursorRadius: const Radius.circular(10),
      controller: controller,
      autofocus: autoFocus,
      decoration: InputDecoration(
        focusColor: Colors.transparent,
        fillColor: AppColors.whiteColor,
        contentPadding: contentPadding,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.greyColor,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.greyColor,
              ),
            ),
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.greyColor,
              ),
            ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        labelText: labelText,
        prefixText: prefixText,
        prefixStyle: Theme.of(context).textTheme.bodyText2,
        labelStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
