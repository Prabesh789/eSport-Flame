import 'dart:developer';

import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/const/const.dart';
import 'package:esport_flame/feature/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: adminPaddnelButtonData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final data = adminPaddnelButtonData[index];
            return AdminPannelCards(
              mediaQuery: mediaQuery,
              onTap: () {
                log('$index');
              },
              text: data['buttonText'],
            );
          },
        ));
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
    );
  }
}
