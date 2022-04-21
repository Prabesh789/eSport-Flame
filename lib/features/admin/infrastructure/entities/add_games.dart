import 'dart:io';

class AddAdsRequest {
  AddAdsRequest({
    required this.gameTitle,
    required this.gameDescpription,
    required this.adsImage,
    required this.gameDescription,
    required this.matchDate,
    required this.winnerPrize,
  });
  final String gameTitle;
  final String gameDescpription;
  final File adsImage;
  final String matchDate;
  final String winnerPrize;
  final String gameDescription;
}
