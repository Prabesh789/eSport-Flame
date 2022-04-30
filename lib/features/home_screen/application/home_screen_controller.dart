import 'package:esport_flame/core/const/const.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/features/home_screen/infrastructure/home_screen_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

HomeScreenController<T> homeScreenController<T>(Ref ref) {
  return HomeScreenController<T>(
    ref.read,
  );
}

final tournamentStateProvider = StateProvider<TournamentsStatus>(
  (ref) {
    return TournamentsStatus.none;
  },
);

class HomeScreenController<T> extends StateNotifier<BaseState> {
  HomeScreenController(
    this._read,
  ) : super(const BaseState<void>.initial());
  final Reader _read;
  IHomeRepository get _homeScreenRepo => _read(homeScreenRepository);

  Future<void> updateTournamentStatus(String docId, int status) async {
    state = const BaseState<void>.loading();
    final response =
        await _homeScreenRepo.updateTournamantsStatus(docId, status);

    state = response.fold(
      (success) => const BaseState.success(),
      (error) => BaseState.error(error),
    );
  }
}
