import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_shimmer.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/menu_nav_bar/menu_nav_bar.dart';
import 'package:esport_flame/features/my_game_screen/widgets/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyGameScreen extends ConsumerStatefulWidget {
  const MyGameScreen({Key? key, this.mediaQuery}) : super(key: key);
  final Size? mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyGameScreenState();
}

class _MyGameScreenState extends ConsumerState<MyGameScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.redColor,
        child: MenuNavBar(),
      ),
      appBar: AppBar(
        title: Text(
          'My Games',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('tournaments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log('Error !!!');
            return const SizedBox();
          } else if (snapshot.hasData) {
            final userId = ref.watch(userIdProvider.notifier).state;
            final tournamentData = snapshot.data! as QuerySnapshot;
            final myGames = tournamentData.docs
                .where(
                  (element) => element['participants'].contains(userId) as bool,
                )
                .toList();
            if (myGames.isNotEmpty) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: myGames.length,
                itemBuilder: (context, index) {
                  final _data = myGames[index];
                  return _ImgSection(
                    mediaQuery: mediaQuery,
                    tournamentData: _data,
                  );
                },
                separatorBuilder: (ctx, x) {
                  return const Divider(
                    height: 15,
                    color: AppColors.greyColor,
                  );
                },
              );
            } else {
              return Center(
                child: SizedBox(
                  width: mediaQuery.width / 1.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/empty.svg',
                        height: mediaQuery.height / 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        child: Text(
                          'You Have Not Been Participated In Any Games Yet.',
                          style: GoogleFonts.merriweather(
                            textStyle:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _ImgSection extends ConsumerWidget {
  const _ImgSection({
    Key? key,
    this.mediaQuery,
    required this.tournamentData,
  }) : super(key: key);
  final Size? mediaQuery;
  final QueryDocumentSnapshot<Object?> tournamentData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider.notifier).state;
    final _isParticipated =
        tournamentData['participants'].contains(userId) as bool;
    return Container(
      width: mediaQuery!.width,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            '${tournamentData['gameTitle']}',
            style: GoogleFonts.merriweather(
              textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: mediaQuery!.width / 2,
                  height: mediaQuery!.width / 2.4,
                  imageUrl: '${tournamentData['posterImage']}',
                  fit: BoxFit.cover,
                  errorWidget: (ctx, str, dynamic dy) {
                    return CustomShimmer(
                      width: mediaQuery!.width,
                      height: mediaQuery!.width,
                    );
                  },
                  placeholder: (ctx, str) {
                    return CustomShimmer(
                      width: mediaQuery!.width / 2,
                      height: mediaQuery!.width / 2.4,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  _Details(
                    title: 'Started date',
                    subTitle: '${tournamentData['matchDate']}',
                  ),
                  _Details(
                    title: 'Booking open',
                    subTitle: '${tournamentData['bookingOpenDate']}',
                  ),
                  _Details(
                    title: 'Date-line',
                    subTitle: '${tournamentData['deadLineDate']}',
                  ),
                  _Details(
                    title: 'Winner Prize',
                    subTitle: '${tournamentData['winnerPrize']}',
                  ),
                  if (_isParticipated)
                    const _Details(
                      title: 'Participation',
                      subTitle: '',
                      widget: Icon(
                        Icons.check_circle,
                        color: AppColors.greencolor,
                      ),
                    )
                  else
                    const SizedBox()
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.touch_app),
                onPressed: () {
                  PaymentMethodAlertBox.showAlert(
                    docId: tournamentData.id,
                    context: context,
                    description: '${tournamentData['gameInfo']}',
                    gameTitle: '${tournamentData['gameTitle']}',
                    isParticipant: _isParticipated,
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key,
    required this.title,
    required this.subTitle,
    this.widget,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.merriweather(
                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            widget ?? const SizedBox(),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              subTitle,
              style: GoogleFonts.merriweather(
                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        )
      ],
    );
  }
}
