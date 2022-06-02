import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(
          key: key,
        );
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                text,
                style: GoogleFonts.baskervville(
                  textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
