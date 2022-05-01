import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/home_screen/application/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateTournamantStatusController =
    StateNotifierProvider.autoDispose<HomeScreenController, BaseState>(
        homeScreenController);

class TournamentAlertBox {
  static Future showAlert({
    required String docId,
    required BuildContext context,
    required String gameTitle,
    required String description,
    required bool isParticipant,
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
          docId: docId,
          isParticipant: isParticipant,
        ),
      ),
    );
  }
}

class TournamentDetail extends ConsumerStatefulWidget {
  const TournamentDetail({
    Key? key,
    required this.description,
    required this.docId,
    required this.isParticipant,
  }) : super(key: key);
  final String description;
  final String docId;
  final bool isParticipant;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TournamentDetailState();
}

class _TournamentDetailState extends ConsumerState<TournamentDetail> {
  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(updateTournamantStatusController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            !widget.isParticipant
                ? 'Thank You For Participation'
                : 'You Have Removed Your Participation',
            Icons.check_circle,
            AppColors.greencolor,
          );
          Navigator.of(context).pop();
        },
        error: (_) {
          context.showSnackBar(
              'Something went wrong !!!', Icons.error, AppColors.redColor);
        },
        orElse: () => const LinearProgressIndicator(
          backgroundColor: AppColors.blueColor,
        ),
      );
    });

    final state = ref.watch(updateTournamantStatusController);
    final userId = ref.watch(userIdProvider);

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
              width: mediaQuery.width / 2,
              child: CustomButton(
                isLoading:
                    state.maybeMap(orElse: () => false, loading: (_) => true),
                buttontextStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor),
                buttonText: widget.isParticipant
                    ? 'Remove Participation'.toUpperCase()
                    : 'Participate'.toUpperCase(),
                onPressed: () {
                  if (widget.isParticipant) {
                    ref
                        .read(updateTournamantStatusController.notifier)
                        .removeParticipant(widget.docId);
                  } else {
                    ref
                        .read(updateTournamantStatusController.notifier)
                        .updateTournamentStatus(widget.docId, userId);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
