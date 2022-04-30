import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDataCard extends StatelessWidget {
  const AppDataCard({
    Key? key,
    required this.img,
    required this.policyDes,
    required this.policyTitle,
  }) : super(key: key);

  final String policyTitle;
  final String img;
  final String policyDes;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: mediaQuery.width / 1.2,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(10, 10),
              blurRadius: 50,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(
              child: SvgPicture.asset(
                img,
                height: 140,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              policyTitle,
              style: GoogleFonts.merriweather(
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                policyDes,
                style: GoogleFonts.merriweather(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: AppColors.greyColor, fontSize: 12),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
