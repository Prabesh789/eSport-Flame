import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuNavBar extends ConsumerStatefulWidget {
  const MenuNavBar({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuNavBarState();
}

class _MenuNavBarState extends ConsumerState<MenuNavBar> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userId = auth.currentUser!.uid;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          setState(() {
            userId = user.uid;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          style: GoogleFonts.average(
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
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 25),
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
                    onTap: () async {},
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