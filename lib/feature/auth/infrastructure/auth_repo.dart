import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository =
    Provider<IAuthRepository>((ref) => AuthRepository(ref.read));

abstract class IAuthRepository {
  Future logout() {
    throw UnimplementedError();
  }
}

class AuthRepository implements IAuthRepository {
  AuthRepository(Reader read);

  @override
  Future logout() {
    throw UnimplementedError();
  }
}
