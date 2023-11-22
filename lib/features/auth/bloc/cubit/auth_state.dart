part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState() = _AuthState;
}

@freezed
class AuthStateInitial with _$AuthStateInitial implements AuthState {
  const factory AuthStateInitial() = _AuthStateInitial;
}

@freezed
class AuthStateLoading with _$AuthStateLoading implements AuthState {
  const factory AuthStateLoading() = _AuthStateLoading;
}

@freezed
class AuthStateAuthSuccess with _$AuthStateAuthSuccess implements AuthState {
  const factory AuthStateAuthSuccess(User user) = _AuthStateAuthSuccess;
}

@freezed
class AuthStateAuthFailed with _$AuthStateAuthFailed implements AuthState {
  const factory AuthStateAuthFailed(Exception exception, String message) = _AuthStateAuthFailed;
}
