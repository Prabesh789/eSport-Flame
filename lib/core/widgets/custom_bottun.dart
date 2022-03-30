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
    this.verticalPadding,
    this.textPadding,
    this.borderColor,
    this.buttontextStyle,
    this.buttonSubTitleText,
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
  final double? verticalPadding;
  final EdgeInsetsGeometry? textPadding;
  final Color? borderColor;
  final TextStyle? buttontextStyle;
  final String? buttonSubTitleText;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      onTap: isLoading || disabled ? null : onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 15,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: isLoading || disabled
              ? AppColors.greyColor
              : (buttonColor ?? AppColors.redColor),
          borderRadius: borderRadiusGeometry ?? BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            leadingWidget ?? const SizedBox(),
            isLoading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                      strokeWidth: 2.0,
                    ),
                  )
                : Padding(
                    padding: textPadding ??
                        EdgeInsets.only(
                          left: !hasIcon ? 0 : 15,
                          top: 2,
                        ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            buttonText.toString().trim(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.average(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          buttonSubTitleText != null
                              ? Text(
                                  buttonSubTitleText!.toString().trim(),
                                  textAlign: TextAlign.center,
                                  style: buttontextStyle ??
                                      Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color: textColor ??
                                                AppColors.whiteColor,
                                            fontSize: 11,
                                          ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
            isLoading
                ? const SizedBox()
                : hasIcon
                    ? Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: trailingIcon ??
                            const Icon(
                              Icons.arrow_forward,
                              color: AppColors.whiteColor,
                            ),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
