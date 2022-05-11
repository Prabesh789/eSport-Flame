import 'package:esport_flame/core/const/app_data.dart';
import 'package:esport_flame/features/menu_nav_bar/widgets/app_data_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: aboutApp.length,
        itemBuilder: (ctx, index) {
          final _data = aboutApp[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppDataCard(
              img: _data['img'],
              policyTitle: _data['title'],
              policyDes: _data['description'],
            ),
          );
        },
      ),
    );
  }
}
