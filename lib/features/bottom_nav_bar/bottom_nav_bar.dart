import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/features/home_screen/presentation/home_screen.dart';
import 'package:esport_flame/features/my_game_screen/my_game_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    MyGameScreen(),
  ];

  int _selectedIndex = 0;

  // _onTap function
  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        switchInCurve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 200),
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: SizedBox(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTap,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.blackColor,
            iconSize: 27,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.whiteColor,
            unselectedItemColor: AppColors.greyColor,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
            selectedLabelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w800,
                ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home page',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.gamepad,
                ),
                label: 'My games',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
