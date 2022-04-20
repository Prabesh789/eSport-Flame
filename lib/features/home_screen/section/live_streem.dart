import 'package:esport_flame/core/video_players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveStreem extends ConsumerStatefulWidget {
  const LiveStreem({Key? key}) : super(key: key);

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
      body: const Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(
            // url: url.data as String,
            url: 'https://youtu.be/caoP4dj2oro',
          ),
        ),
      ),
    );
  }
}
