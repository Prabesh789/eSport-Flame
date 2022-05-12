import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/features/home_screen/application/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

final feesPaymentController =
    StateNotifierProvider.autoDispose<HomeScreenController, BaseState>(
        homeScreenController);

class PaymentMethodAlertBox {
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
    ref.listen<BaseState>(feesPaymentController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            '',
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
    final state = ref.watch(feesPaymentController);

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
            const SizedBox(
              height: 10,
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
                buttonText: 'PAY ENTRY FEES',
                onPressed: () {
                   KhaltiScope.of(context).pay(
                            config: PaymentConfig(
                              amount: getAmt(),
                              productIdentity: 'dells-sssssg5-g5510-2021',
                              productName: 'Product Name',
                            ),
                            preferences: [
                              PaymentPreference.khalti,
                            ],
                            onSuccess: (su) {
                              
                              const successsnackBar = SnackBar(
                                content: Text('Money added Successful'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(successsnackBar);
                              Navigator.pop(context);
                            },
                            onFailure: (fa) {
                              const failedsnackBar = SnackBar(
                                content: Text('Money added Failed'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(failedsnackBar);
                            },
                            onCancel: () {
                              const cancelsnackBar = SnackBar(
                                content: Text('Payment Cancelled'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(cancelsnackBar);
                            },
                          );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getAmt() {
    return int.parse('1000');
  }
}
