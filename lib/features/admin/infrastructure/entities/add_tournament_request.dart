import 'dart:io';

class AddTournament {
  AddTournament({
    required this.gameTitle,
    required this.gameDescpription,
    required this.gamePosterImage,
    required this.matchDate,
    required this.winnerPrize,
  });
  final String gameTitle;
  final String gameDescpription;
  final File gamePosterImage;
  final String matchDate;
  final String winnerPrize;
}
