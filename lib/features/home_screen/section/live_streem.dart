import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/video_players.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveStreem extends ConsumerStatefulWidget {
  const LiveStreem({Key? key, required this.mediaQuery}) : super(key: key);
  final Size mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveStreemState();
}

class _LiveStreemState extends ConsumerState<LiveStreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Streems',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: CustomBodyWidget(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('videos').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log('Warning error alert !!!');
              return const SizedBox();
            } else if (snapshot.hasData) {
              final _videosData = snapshot.data as QuerySnapshot;
              return SingleChildScrollView(
                child: SizedBox(
                  height: widget.mediaQuery.height,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _videosData.docs.length,
                    itemBuilder: (ctx, index) {
                      final _data = _videosData.docs[index];
                      return Video(
                        mediaQuery: widget.mediaQuery,
                        videoUrl: _data['videoUrl'],
                        title: _data['videotitle'],
                      );
                    },
                    separatorBuilder: (ctx, a) {
                      return const Divider();
                    },
                  ),
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmer(
                          height: widget.mediaQuery.height / 3.5,
                          width: widget.mediaQuery.width,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (ctx, as) {
                    return const Divider(
                      height: 20,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Video extends StatelessWidget {
  const Video({
    Key? key,
    required this.mediaQuery,
    required this.videoUrl,
    required this.title,
  }) : super(key: key);

  final Size mediaQuery;
  final String videoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            // height: mediaQuery.height / 4,
            decoration: BoxDecoration(
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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 3),
            ),
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(
                  url: videoUrl.toString(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: GoogleFonts.baskervville(
                textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      );
    });
  }
}
