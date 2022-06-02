import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.isLoading = false,
    this.buttonColor,
    this.trailingIcon,
    this.textColor,
    this.hasIcon = true,
    required this.buttonText,
    required this.onPressed,
    this.leadingWidget,
    this.borderRadiusGeometry,
    this.fontSize,
    this.textPadding,
    this.borderColor,
    this.buttontextStyle,
    this.disabled = false,
  }) : super(key: key);
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final Widget? leadingWidget;
  final bool isLoading;
  final Widget? trailingIcon;
  final Color? textColor;
  final bool hasIcon;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final double? fontSize;

  final EdgeInsetsGeometry? textPadding;
  final Color? borderColor;
  final TextStyle? buttontextStyle;

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      onTap: isLoading || disabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: isLoading || disabled
              ? AppColors.greyColor
              : (buttonColor ?? AppColors.redColor),
          borderRadius: borderRadiusGeometry ?? BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.whiteColor,
                    ),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  buttonText.trim(),
                  textAlign: TextAlign.center,
                  style: buttontextStyle ??
                      GoogleFonts.average(
                        textStyle:
                            Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                ),
        ),
      ),
    );
  }
}
