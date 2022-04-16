import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/feature/auth/application/controller/auth_controller.dart';
import 'package:esport_flame/feature/auth/application/entities/login_request.dart';
import 'package:esport_flame/feature/auth_screen/signup_dialog.dart';
import 'package:esport_flame/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  void _togglevisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    ref.listen<BaseState>(signInController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
              'Login Successfull.', Icons.check_circle, AppColors.greencolor);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const BottomNavBar(),
            ),
          );
        },
        error: (_) {
          context.showSnackBar(
              'Something went wrong !!!', Icons.error, AppColors.redColor);
          _userNameController.clear();
          _passwordController.clear();
        },
        orElse: () => const LinearProgressIndicator(
          backgroundColor: AppColors.blueColor,
        ),
      );
    });
    final state = ref.watch(signInController);
    final isLoading = state == const BaseState<void>.loading();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to E-sport Flame'),
      ),
      body: Form(
        key: _formKey,
        child: CustomBodyWidget(
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
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        obscureText: obscureText,
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
                      CustomButton(
                        isLoading: isLoading,
                        buttonText: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(signInController.notifier).loginUser(
                                  loginRequest: LoginRequest(
                                    email: _userNameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
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
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userNameFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
