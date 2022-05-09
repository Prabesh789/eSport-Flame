import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_shimmer.dart';
import 'package:esport_flame/features/admin/presentation/sections/add_tournaments.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/home_screen/presentation/section/widgets/tournament_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayTournaments extends ConsumerStatefulWidget {
  const PlayTournaments({Key? key, this.mediaQuery, this.title})
      : super(key: key);
  final Size? mediaQuery;
  final String? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlayTournamentsState();
}

class _PlayTournamentsState extends ConsumerState<PlayTournaments> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? 'Play Tournaments',
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
            final tournamentData = snapshot.data as QuerySnapshot;
            if (tournamentData.docs.isNotEmpty) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: tournamentData.docs.length,
                itemBuilder: (context, index) {
                  final _data = tournamentData.docs[index];

                  return _ImgSection(
                    mediaQuery: widget.mediaQuery,
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
                  width: widget.mediaQuery!.width / 1.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/empty.svg',
                        height: widget.mediaQuery!.height / 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        child: Text(
                          'No Any Tournaments Added Yet.',
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
    final _useStatus = ref.watch(isUserAdminProvider);
    log('=> $userId');
    return Container(
      width: mediaQuery!.width,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            tournamentData['gameTitle'],
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: mediaQuery!.width / 2,
                  height: mediaQuery!.width / 2.4,
                  imageUrl: tournamentData['posterImage'],
                  fit: BoxFit.cover,
                  errorWidget: (ctx, str, dy) {
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
                    subTitle: tournamentData['matchDate'],
                  ),
                  _Details(
                    title: 'Booking open',
                    subTitle: tournamentData['bookingOpenDate'],
                  ),
                  _Details(
                    title: 'Date-line',
                    subTitle: tournamentData['deadLineDate'],
                  ),
                  _Details(
                    title: 'Winner Prize',
                    subTitle: tournamentData['winnerPrize'],
                  ),
                  tournamentData['participants'].contains(userId)
                      ? const _Details(
                          title: 'Participation',
                          subTitle: '',
                          widget: Icon(
                            Icons.check_circle,
                            color: AppColors.greencolor,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(!_useStatus ? Icons.touch_app : Icons.edit),
                onPressed: () {
                  if (!_useStatus) {
                    TournamentAlertBox.showAlert(
                      docId: tournamentData.id,
                      context: context,
                      description: tournamentData['gameInfo'],
                      gameTitle: tournamentData['gameTitle'],
                      isParticipant:
                          tournamentData['participants'].contains(userId),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddTournaments(
                          isEdit: true,
                          mediaQuery: mediaQuery,
                          title: tournamentData['gameTitle'],
                          description: tournamentData['gameInfo'],
                          matchDate: tournamentData['matchDate'],
                          bookingDate: tournamentData['bookingOpenDate'],
                          deadLine: tournamentData['deadLineDate'],
                          prize: tournamentData['winnerPrize'],
                          imgUrl: tournamentData['posterImage'],
                          docId: tournamentData.id,
                        ),
                      ),
                    );
                  }
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
