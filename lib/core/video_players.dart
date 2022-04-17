import 'package:flutter/material.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    initController();
    super.initState();
  }

  Future<void> initController() async {
    _controller = YoutubePlayerController(
      initialVideoId: convertUrlToId(widget.url) ?? '',
      params: const YoutubePlayerParams(
        startAt: Duration(seconds: 10),
        autoPlay: false,
        enableCaption: false,
        playsInline: true,
        desktopMode: false,
        enableKeyboard: false,
        loop: true,
        showVideoAnnotations: false,
        playlist: [],
        showControls: true,
        showFullscreenButton: true,
        privacyEnhanced: true,
        strictRelatedVideos: true,
      ),
    )..listen((value) {
        if (value.isReady && !value.hasPlayed) {
          _controller
            ..hidePauseOverlay()
            ..play()
            ..hideTopMenu();
        }
        if (value.hasPlayed) {
          _controller.hideEndScreen();
        }
      });
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains('http') && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(
          r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$')
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
