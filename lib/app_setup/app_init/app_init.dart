import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AppInit {
  static const uuid = Uuid();

  static final provider = ProviderContainer();
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
