import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/feature/auth_screen/signup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to E-sport Flame'),
      ),
      body: CustomBodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    SizedBox(
                      height: mediaQuery.height / 4,
                      child: SvgPicture.asset('assets/login.svg'),
                    ),
                    SizedBox(height: mediaQuery.width / 4),
                    CustomTextField(
                      labelText: 'Username',
                      context: context,
                      controller: _userNameController,
                      prefixIcon: const Icon(Icons.person),
                      focusNode: _userNameFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      labelText: 'Password',
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
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          SignupAlertBox.showAlert(
                              context: context, mediaQuery: mediaQuery);
                        },
                        child: Text(
                          'New signup',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: AppColors.redColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                    )
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
