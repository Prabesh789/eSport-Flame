import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to E-sport Flame'),
      ),
      body: CustomBodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/login_img.jpg',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: GoogleFonts.average(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      context: context,
                      controller: _userNameController,
                      prefixIcon: const Icon(Icons.person),
                      focusNode: _userNameFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Password',
                      style: GoogleFonts.average(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      context: context,
                      controller: _passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      focusNode: _passwordFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      buttonText: 'Login',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
