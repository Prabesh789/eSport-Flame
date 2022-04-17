import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/feature/auth/application/controller/auth_controller.dart';
import 'package:esport_flame/feature/auth_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final logOutUserController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

class MenuNavBar extends ConsumerStatefulWidget {
  const MenuNavBar({Key? key, this.isFromAdminPannel = false})
      : super(key: key);
  final bool? isFromAdminPannel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuNavBarState();
}

class _MenuNavBarState extends ConsumerState<MenuNavBar> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userId = auth.currentUser!.uid;

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

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    ref.listen<BaseState>(logOutUserController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
              'Logout', Icons.check_circle, AppColors.greencolor);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SignInScreen()));
        },
        error: (_) {
          context.showSnackBar(
              'Something went wrong !!!', Icons.error, AppColors.redColor);
        },
        orElse: () {},
      );
    });
    return Container(
      color: AppColors.greyColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            child: StreamBuilder<Object>(
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
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.greyColor,
                        child: Text(
                          '${userData['nickName'][0]}'.toUpperCase(),
                          style: GoogleFonts.playball(
                            textStyle:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${userData['nickName']}',
                        style: GoogleFonts.ptSerif(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      Text(
                        '${userData['email']}',
                        style: GoogleFonts.ptSerif(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isFromAdminPannel!)
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                const SizedBox(height: 10),
                if (!widget.isFromAdminPannel!)
                  Card(
                    elevation: 0,
                    color: Theme.of(context).cardColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: ListTile(
                      trailing: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.policy),
                      ),
                      onTap: () async {},
                      title: Text(
                        'Data privacy',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                if (!widget.isFromAdminPannel!)
                  Card(
                    elevation: 0,
                    color: Theme.of(context).cardColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: ListTile(
                      trailing: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.rule),
                      ),
                      onTap: () async {},
                      title: Text(
                        'About App',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: widget.isFromAdminPannel!
                      ? mediaQuery.height / 1.7
                      : mediaQuery.height / 4,
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).cardColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: ListTile(
                    trailing: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.logout),
                    ),
                    onTap: () async {
                      ref.read(logOutUserController.notifier).logOutUser();
                    },
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
