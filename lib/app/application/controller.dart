import 'package:esport_flame/app/entitiles/app_state.dart';
import 'package:esport_flame/feature/auth/infrastructure/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
final appController = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(ref.read)..appStarted();
});

///
class AppStateNotifier extends StateNotifier<AppState> {
  ///
  AppStateNotifier(this._read) : super(const AppState<void>.started());

  final Reader _read;

  ///
  Future<void> appStarted() async {
    state = const AppState<dynamic>.unAuthenticated();
  }

  Future<void> unAuthenticated() async {
    await _read(authRepository).logout();
    state = const AppState<void>.unAuthenticated();
  }

  Future<void> updateAppState(AppState<void> appState) async {
    state = appState;
  }
}
