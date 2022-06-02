import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class DialogBox {
  static Future showAlert(
    BuildContext context,
    String nickName,
  ) {
    return showDialog<AlertDialog>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
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
              'Remove User',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 15)
          ],
        ),
        content: _Body(
          nickName: nickName,
        ),
        actions: const [],
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({Key? key, required this.nickName}) : super(key: key);
  final String nickName;

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
                  text: '${widget.nickName} ?',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
