import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class WithdrawAlertBox {
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
              'withdraw with khalti',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 15)
          ],
        ),
        content: withdrawSection(
          mediaQuery: mediaQuery,
          userId: userId,
          totalammount: totalammount,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class withdrawSection extends ConsumerStatefulWidget {
  const withdrawSection(
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

class _SignupSectionState extends ConsumerState<withdrawSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contactNocontroller = TextEditingController();
  final _withdrawController = TextEditingController();
  final _fullNamecontroller = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _contactNocontroller.dispose();

    super.dispose();
  }

  void _togglevisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future withdrawBalance() async {
    // if (_formKey.currentState!.validate()) {
    final userRef = FirebaseFirestore.instance.collection('AccountBalance');

    await userRef.doc(widget.userId).update({
      'contactNo': _contactNocontroller.text.trim(),
      'toEmail': _emailController.text.trim(),
      'fullName': _fullNamecontroller.text.trim(),
      'ammount': (int.parse(widget.totalammount) -
              int.parse(_withdrawController.text.trim()))
          .toString(),
      'withdrawammount': _withdrawController.text.trim()
    });
    // }
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
                  CustomTextField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Full name',
                    context: context,
                    controller: _fullNamecontroller,
                    prefixIcon: const Icon(
                      Icons.near_me,
                      size: 18,
                    ),
                    onEditingComplete: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Full name required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomTextField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Email',
                    context: context,
                    controller: _emailController,
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 18,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {},
                    validator: (String? value) {
                      /**regex for email validation */
                      final regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );
                      if (value!.isEmpty) {
                        return 'Email invalid';
                      } else if (!regex.hasMatch(value)) {
                        return 'Email invalid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    keyboardType: TextInputType.number,
                    labelText: 'Contact',
                    context: context,
                    controller: _contactNocontroller,
                    prefixIcon: const Icon(
                      Icons.phone,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contact No. required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    labelText: 'Withdrawl ammount',
                    context: context,
                    controller: _withdrawController,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'withdrwa ammount required';
                      } else if (int.parse(value) >
                          int.parse(widget.totalammount)) {
                        return 'not sufficient ammount';
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
                      buttonText: 'withdraw with khalti',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(_withdrawController);
                          withdrawBalance();
                          context.showSnackBar(
                            'Withdraw completed',
                            Icons.check_circle,
                            AppColors.greencolor,
                          );
                          Navigator.pop(context);
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
