import 'dart:io';

class AddAdsRequest {
  AddAdsRequest({
    required this.adsTitle,
    required this.adsDescpription,
    required this.adsImage,
  });
  final String adsTitle;
  final String adsDescpription;
  final File adsImage;
}
