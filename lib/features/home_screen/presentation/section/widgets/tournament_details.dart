import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TournamentAlertBox {
  static Future showAlert({
    required BuildContext context,
    required String gameTitle,
    required String description,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        title: Center(
          child: Text(
            gameTitle,
            style: GoogleFonts.merriweather(
              textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: TournamentDetail(
          description: description,
        ),
      ),
    );
  }
}

class TournamentDetail extends ConsumerStatefulWidget {
  const TournamentDetail({Key? key, required this.description})
      : super(key: key);
  final String description;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TournamentDetailState();
}

class _TournamentDetailState extends ConsumerState<TournamentDetail> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      height: mediaQuery.height / 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.description,
              style: GoogleFonts.merriweather(
                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(),
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              width: mediaQuery.width / 3,
              child: CustomButton(
                // isLoading: isLoading,
                buttontextStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor),
                buttonText: 'Participate'.toUpperCase(),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
