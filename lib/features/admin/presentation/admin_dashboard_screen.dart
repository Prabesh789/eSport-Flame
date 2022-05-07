import 'dart:developer';

import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/const/const.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/features/admin/presentation/sections/add_ads.dart';
import 'package:esport_flame/features/admin/presentation/sections/add_popluar_game.dart';
import 'package:esport_flame/features/admin/presentation/sections/add_tournaments.dart';
import 'package:esport_flame/features/admin/presentation/sections/add_videos.dart';
import 'package:esport_flame/features/admin/presentation/sections/user_list.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/auth_screen/presentation/sign_in_screen.dart';
import 'package:esport_flame/features/home_screen/presentation/section/live_streem.dart';
import 'package:esport_flame/features/home_screen/presentation/section/play_tournaments.dart';
import 'package:esport_flame/features/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final logOutAdminController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    ref.listen<BaseState>(logOutAdminController, (oldState, state) {
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
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.redColor,
        child: MenuNavBar(
          isFromAdminPannel: true,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Admin Pannel',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: adminPannelButtonData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final data = adminPannelButtonData[index];
                return AdminPannelCards(
                  mediaQuery: mediaQuery,
                  onTap: () {
                    log('$index');
                    if (index == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddAds(
                                mediaQuery: mediaQuery,
                              )));
                    } else if (index == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddTournaments(
                                mediaQuery: mediaQuery,
                              )));
                    } else if (index == 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddPopularGames(
                                mediaQuery: mediaQuery,
                              )));
                    } else if (index == 3) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddVideos(
                                mediaQuery: mediaQuery,
                              )));
                    }
                  },
                  text: data['buttonText'],
                );
              },
            ),
            const Divider(),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: adminPannelListButtonData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final data = adminPannelListButtonData[index];
                return AdminPannelCards(
                  mediaQuery: mediaQuery,
                  onTap: () {
                    log('$index');
                    if (index == 0) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const UserList()));
                    } else if (index == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PlayTournaments(
                                mediaQuery: mediaQuery,
                                title: 'Tournaments List',
                              )));
                    } else if (index == 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => LiveStreem(
                                mediaQuery: mediaQuery,
                              )));
                    }
                  },
                  text: data['buttonText'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPannelCards extends StatelessWidget {
  const AdminPannelCards({
    Key? key,
    required this.mediaQuery,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final Size mediaQuery;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: mediaQuery.width / 2.3,
        width: mediaQuery.width / 2.3,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Center(
          child: Align(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                text,
                style: GoogleFonts.tinos(
                  textStyle: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
