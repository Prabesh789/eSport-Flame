import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/menu_nav_bar/widgets/my_wallet_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/ammount_model.dart';

final signupController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class AddBalance {
  static Future showAlert({
    required BuildContext context,
    required Size mediaQuery,
    required String userId,
    required String totalammount,
  }) {
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
                Icons.arrow_back_ios,
                size: 14,
              ),
            ),
            Text(
              'Add balance with Khalti',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 15)
          ],
        ),
        content: AddBalanceSection(
          mediaQuery: mediaQuery,
          userId: userId,
          totalammount: totalammount,
        ),
      ),
    );
  }
}

class AddBalanceSection extends ConsumerStatefulWidget {
  const AddBalanceSection(
      {Key? key,
      required this.mediaQuery,
      required this.userId,
      required this.totalammount})
      : super(key: key);
  final Size mediaQuery;
  final String userId;

  final String totalammount;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupSectionState();
}

class _SignupSectionState extends ConsumerState<AddBalanceSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _ammountController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _ammountController.dispose();

    super.dispose();
  }

  Future addBalance() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    final firebaseFirestore = FirebaseFirestore.instance;
    final user = _auth.currentUser;

    final ammountModel = AmmountModel();

    // writing all the values

    ammountModel.uid = user!.uid;

    ammountModel.ammount = (int.parse(_ammountController.text.trim()) +
            int.parse(widget.totalammount))
        .toString();

    await firebaseFirestore
        .collection('AccountBalance')
        .doc(ammountModel.uid)
        .set(ammountModel.toMap());

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => HomeScreen()),
    //     (route) => false);
  }

  void _togglevisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupController);
    final isLoading = state == const BaseState<void>.loading();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: widget.mediaQuery.height / 2.3,
          child: CustomBodyWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: widget.mediaQuery.width * 0.02),
                  const SizedBox(height: 10),
                  CustomTextField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    keyboardType: TextInputType.number,
                    labelText: 'Ammount',
                    context: context,
                    controller: _ammountController,
                    prefixIcon: const Icon(
                      Icons.wallet_giftcard,
                      size: 18,
                    ),
                    onEditingComplete: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ammount required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 48,
                    child: CustomButton(
                      isLoading: isLoading,
                      buttontextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.whiteColor),
                      buttonText: 'Add with khalti',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AddBalance();
                          context.showSnackBar(
                            'Balance Added',
                            Icons.check_circle,
                            AppColors.greencolor,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute<Mywallet>(
                              builder: (context) => const Mywallet(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
