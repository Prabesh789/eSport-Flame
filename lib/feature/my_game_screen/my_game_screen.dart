import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/feature/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';

class MyGamesScreen extends StatefulWidget {
  const MyGamesScreen({Key? key}) : super(key: key);

  @override
  State<MyGamesScreen> createState() => _MyGamesScreenState();
}

class _MyGamesScreenState extends State<MyGamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.redColor,
        child: MenuNavBar(),
      ),
      appBar: AppBar(
        title: const Text('My Games'),
      ),
    );
  }
}
