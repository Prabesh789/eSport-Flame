import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupAlertBox {
  static Future showAlert({
    required BuildContext context,
    required Size mediaQuery,
  }) {
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
                Icons.arrow_back_ios,
                size: 14,
              ),
            ),
            Text(
              'Sign up with Email',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 15)
          ],
        ),
        content: SignupSection(
          mediaQuery: mediaQuery,
        ),
      ),
    );
  }
}

class SignupSection extends ConsumerStatefulWidget {
  const SignupSection({Key? key, required this.mediaQuery}) : super(key: key);
  final Size mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupSectionState();
}

class _SignupSectionState extends ConsumerState<SignupSection> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nickNamecontroller = TextEditingController();
  final _emialFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nickNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: widget.mediaQuery.height / 3,
        child: CustomBodyWidget(
          child: Column(
            children: [
              SizedBox(height: widget.mediaQuery.width * 0.02),
              CustomTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Email',
                context: context,
                controller: _emailController,
                prefixIcon: const Icon(
                  Icons.email,
                  size: 18,
                ),
                focusNode: _emialFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_nickNameFocusNode);
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Nick name',
                context: context,
                controller: _nickNamecontroller,
                prefixIcon: const Icon(
                  Icons.near_me,
                  size: 18,
                ),
                focusNode: _nickNameFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Password',
                context: context,
                controller: _passwordController,
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 18,
                ),
                focusNode: _passwordFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 45,
                child: CustomButton(
                  // textPadding: ,
                  buttontextStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: AppColors.whiteColor),

                  buttonText: 'Signup',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
