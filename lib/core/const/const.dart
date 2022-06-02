enum AccountType {
  admin,
  general,
  none,
}

enum TournamentsStatus {
  none,
  participated,
  readyToPlay,
}

final List<Map<String, String>> adminPannelButtonData = [
  {'buttonText': 'Add Ads'},
  {'buttonText': 'Add Tournaments'},
  {'buttonText': 'Add Popular Games'},
  {'buttonText': 'Add Videos'},
];

final List<Map<String, String>> adminPannelListButtonData = [
  {'buttonText': 'Users List'},
  {'buttonText': 'Tournaments List'},
  {'buttonText': 'Popular Games List'},
];
