import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final adsImagePickedNotifier =
    ChangeNotifierProvider<AdsImagePickedNotifier>((ref) {
  return AdsImagePickedNotifier();
});

class AdsImagePickedNotifier extends ValueNotifier<bool> {
  AdsImagePickedNotifier() : super(false);
  void isPicked({required bool updatedValue}) {
    value = updatedValue;
  }
}
