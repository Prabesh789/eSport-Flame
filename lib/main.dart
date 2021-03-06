import 'package:esport_flame/app_setup/app_init/app_init.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/features/auth_screen/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  await AppInit.initialize();
  runApp(
    const ProviderScope(child: MyApp()),
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
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
          headline3: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          bodyText1: TextStyle(
            fontSize: 20,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          subtitle1: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}
