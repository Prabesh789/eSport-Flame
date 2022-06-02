import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final signupController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class SignupAlertBox {
  static Future showAlert({
    required BuildContext context,
    required Size mediaQuery,
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contactNocontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _nickNamecontroller = TextEditingController();
  final _emialFocusNode = FocusNode();
  final _contactNoFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nickNameFocusNode = FocusNode();

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _contactNocontroller.dispose();
    _passwordController.dispose();
    _nickNamecontroller.dispose();
    _emialFocusNode.dispose();
    _contactNoFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nickNameFocusNode.dispose();
    super.dispose();
  }

  void _togglevisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(signupController, (oldState, state) {
      state.maybeWhen(
        success: (dynamic _) {
          Navigator.of(context).pop();
          context.showSnackBar(
            'Successfully registered.',
            Icons.check_circle,
            AppColors.greencolor,
          );
        },
        error: (_) {
          context.showSnackBar(
            'Something went wrong !!!',
            Icons.error,
            AppColors.redColor,
          );
          Navigator.of(context).pop();
        },
        orElse: () => const LinearProgressIndicator(
          backgroundColor: AppColors.blueColor,
        ),
      );
    });
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
                    labelText: 'Email',
                    context: context,
                    controller: _emailController,
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 18,
                    ),
                    focusNode: _emialFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_contactNoFocusNode);
                    },
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
                    focusNode: _contactNoFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_nickNameFocusNode);
                    },
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nick name required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    obscureText: obscureText,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                    validator: (value) {
                      if (value!.isEmpty && value.length < 8) {
                        return 'Password must have 8 character.';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: _togglevisibility,
                        child: Text(
                          obscureText ? 'show' : 'hide',
                          style: GoogleFonts.ptSerif(
                            textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                      buttonText: 'Signup',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(signupController.notifier).signupUser(
                                contactNo: _contactNocontroller.text,
                                email: _emailController.text,
                                isAdmin: false,
                                nickName: _nickNamecontroller.text,
                                password: _passwordController.text,
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
