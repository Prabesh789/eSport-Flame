import 'package:esport_flame/app_setup/app_init/app_init.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/feature/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await AppInit.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-sport flame',
      theme: ThemeData(
        // scaffoldBackgroundColor: AppColors.blackColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blackColor,
          titleTextStyle: GoogleFonts.average(
            textStyle: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              letterSpacing: .5,
            ),
          ),
          centerTitle: true,
        ),
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 25,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
          headline3: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          bodyText1: TextStyle(
            fontSize: 20,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          subtitle1: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
        ),
      ),
      home: const SigninScreen(),
    );
  }
}
