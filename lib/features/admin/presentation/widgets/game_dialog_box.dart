import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

class GameDialogBox {
  static Future showAlert(
    BuildContext context,
    String gameName,
    String gameid,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
                size: 20,
              ),
            ),
            Text(
              'Remove Game',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 15)
          ],
        ),
        content: _Body(
          gameName: gameName,
          gameid: gameid,
        ),
        actions: const [],
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({Key? key, required this.gameName, required this.gameid})
      : super(key: key);
  final String gameName;
  final String gameid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BodyState();
}

class __BodyState extends ConsumerState<_Body> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      height: mediaQuery.height / 5,
      width: mediaQuery.width / 1.2,
      child: Column(
        children: [
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Are you sure to remove ',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 14,
                      ),
                ),
                TextSpan(
                  text: '${widget.gameName} ?',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                var key = widget.gameid;
                deleteGames(key);
              },
              child: const Text("Yes"))
        ],
      ),
    );
  }
  //delete user records
  deleteGames(var key) async {
    final userRef = FirebaseFirestore.instance.collection('popular_games');
    await userRef.doc(key).delete();
    context.showSnackBar(
        'Deleted record', Icons.check_circle, AppColors.greencolor);
    Navigator.pop(context);
  }
}
