import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/features/admin/infrastructure/admin_repository.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_ads_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AdminController<T> adminController<T>(Ref ref) {
  return AdminController<T>(
    ref.read,
  );
}

class AdminController<T> extends StateNotifier<BaseState> {
  AdminController(
    this._read,
  ) : super(const BaseState<void>.initial());
  final Reader _read;
  IAdminRepository get _adminRepo => _read(adminRepository);

  Future<void> addAds(AddAdsRequest addAdsRequest) async {
    state = const BaseState<void>.loading();
    final response = await _adminRepo.addAds(
      addAdsRequest: addAdsRequest,
    );
    state = response.fold(
      (success) => const BaseState.success(),
      (error) => BaseState.error(error),
    );
  }
}
