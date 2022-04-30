import 'package:esport_flame/core/const/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPolicyScreen extends StatefulWidget {
  const DataPolicyScreen({Key? key}) : super(key: key);

  @override
  _DataPolicyScreenState createState() => _DataPolicyScreenState();
}

class _DataPolicyScreenState extends State<DataPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Policy',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: dataPloicy.length,
        itemBuilder: (ctx, index) {
          final _data = dataPloicy[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: DataPloicy(
              size: size,
              img: _data['img'],
              policyTitle: _data['policyTitle'],
              policyDes: _data['policyDes'],
            ),
          );
        },
      ),
    );
  }
}

class DataPloicy extends StatelessWidget {
  const DataPloicy({
    Key? key,
    required this.size,
    required this.img,
    required this.policyDes,
    required this.policyTitle,
  }) : super(key: key);

  final Size size;
  final String policyTitle;
  final String img;
  final String policyDes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width / 1.2,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(10, 10),
              blurRadius: 50,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(
              child: SvgPicture.asset(
                img,
                height: 140,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              policyTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                policyDes,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
