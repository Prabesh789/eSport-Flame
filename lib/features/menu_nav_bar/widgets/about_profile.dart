import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/custom_bottun.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../auth_screen/presentation/sign_in_screen.dart';

final logOutUserController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

class AboutProfile extends ConsumerStatefulWidget {
  const AboutProfile({Key? key, this.isFromAdminPannel = false})
      : super(key: key);
  final bool? isFromAdminPannel;

  get mediaQuery => null;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuNavBarState();
}

class _MenuNavBarState extends ConsumerState<AboutProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userId = auth.currentUser!.uid;
  String nickname ="";

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contactNocontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _nickNamecontroller = TextEditingController();
 

  bool obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    auth.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          if (mounted) {
            setState(() {
              userId = user.uid;
               
            });
          }
        }
      },
    );
    print(userId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  

  //toogle visibility
  void _togglevisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  profileUpdate() async {
    if (_formKey.currentState!.validate()) {
      final userRef = FirebaseFirestore.instance.collection('users');

      await userRef.doc(userId).update({
        'contactNo': _contactNocontroller.text.trim(),
        'email': _emailController.text.trim(),
        'nickName': _nickNamecontroller.text.trim(),
        'password': _passwordController.text.trim()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final state = ref.watch(signInController);
     final isLoading = state == const BaseState<void>.loading();
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: Container(
            color: Color.fromARGB(255, 251, 243, 243),
            child: Form(
              key: _formKey,
              child: ListView(padding: EdgeInsets.all(20), children: [
                StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else if (snapshot.data != null) {
                      final userData = snapshot.data! as DocumentSnapshot;
                      return Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 246, 41, 171),
                            child: Text(
                              '${userData['nickName'][0]}'.toUpperCase(),
                              style: GoogleFonts.playball(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(children: [
                            //SizedBox(height: widget.mediaQuery.width * 0.02),
                            CustomTextField(
                              isEnabled: false,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              labelText: 'Email',
                              context: context,
                              controller: _emailController
                                ..text = '${userData['email']}',

                              prefixIcon: const Icon(
                                Icons.email,
                                size: 18,
                              ),
                            
                              keyboardType: TextInputType.emailAddress,
                            
                              validator: (String? value) {
                                /**regex for email validation */
                                final regex = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              keyboardType: TextInputType.number,
                              labelText: 'Contact',
                              context: context,
                              controller: _contactNocontroller
                                ..text = '${userData['contactNo']}',
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
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              labelText: 'Nick name',
                              context: context,
                              controller: _nickNamecontroller
                                ..text = '${userData['nickName']}',
                              prefixIcon: const Icon(
                                Icons.near_me,
                                size: 18,
                              ),
                            
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
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              labelText: 'Password',
                              context: context,
                              controller: _passwordController
                                ..text = '${userData['password']}',
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 18,
                              ),
                             
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
                                buttonText: 'Update',
                                onPressed: () {
                                  profileUpdate();

                                  context.showSnackBar('Profile Updated',
                                      Icons.check_circle, AppColors.greencolor);
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ])
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ]),
            )));
  }
}
