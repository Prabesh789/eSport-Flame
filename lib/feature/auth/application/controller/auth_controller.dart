import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/feature/auth/application/entities/login_request.dart';
import 'package:esport_flame/feature/auth/application/entities/login_response.dart';
import 'package:esport_flame/feature/auth/application/entities/signup_request.dart';
import 'package:esport_flame/feature/auth/application/entities/signup_response.dart';
import 'package:esport_flame/feature/auth/infrastructure/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

AuthController<T> authController<T>(Ref ref) {
  return AuthController<T>(
    ref.read,
  );
}

class AuthController<T> extends StateNotifier<BaseState> {
  AuthController(
    this._read,
  ) : super(const BaseState<void>.initial());
  final Reader _read;
  Uuid uuid = const Uuid();
  IAuthRepository get _repo => _read(authRepository);

  Future<void> signupUser({
    required String email,
    required String contactNo,
    required String password,
    required String nickName,
    required bool isAdmin,
  }) async {
    state = const BaseState<void>.loading();

    final requestData = SignupRequest(
      contactNo: contactNo,
      email: email,
      isAdmin: isAdmin,
      nickName: nickName,
      password: password,
    );
    final response = await _repo.signupNewUser(
      newSignupRequest: requestData,
    );
    state = response.fold(
      (success) => BaseState<SignupResponse>.success(data: success),
      (error) => BaseState<Failure>.error(error),
    );
  }

  Future<void> loginUser({required LoginRequest loginRequest}) async {
    state = const BaseState<void>.loading();

    final requestData = LoginRequest(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    final response = await _repo.loginUser(loginRequest: requestData);
    state = response.fold(
      (success) {
        return BaseState<LoginResponse>.success(data: success);
      },
      (error) => BaseState<Failure>.error(error),
    );
  }

  Future<void> logOutUser() async {
    state = const BaseState<void>.loading();
    final response = await _repo.logout();

    state = response.fold(
        (success) => const BaseState.success(), (r) => BaseState.error(r));
  }
}
