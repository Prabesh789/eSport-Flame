import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

///
@freezed
class AppState<T> with _$AppState<T> {
  ///
  const factory AppState.started() = AppStarted<T>;

  ///
  const factory AppState.authenticated(T data) = Authenticated<T>;

  ///
  const factory AppState.unAuthenticated({Failure? failure}) =
      UnAuthenticated<T>;
}
