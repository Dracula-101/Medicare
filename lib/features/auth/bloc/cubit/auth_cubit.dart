import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/services/auth_service/auth_service.dart';
import 'package:medicare/util/helper.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authService,
  }) : super(const AuthStateInitial());

  final AuthService authService;

  Future<void> signInWithEmail(String email, String password) async {
    try {
      emit(const AuthStateLoading());
      await authService.signInWithEmail(email, password).timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Timeout'),
          );
    } on auth.FirebaseAuthException catch (e) {
      emit(AuthStateAuthFailed(
        e,
        ExceptionHelper.getFirebaseAuthExceptionMessage(e.code) ??
            e.message ??
            'Something went wrong',
      ));
    } on Exception catch (e) {
      emit(AuthStateAuthFailed(e, ExceptionHelper.getExceptionMessage(e)));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthStateLoading());
      await authService.signInWithGoogle().timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Timeout'),
          );
      emit(const AuthStateInitial());
    } on auth.FirebaseAuthException catch (e) {
      emit(AuthStateAuthFailed(
        e,
        ExceptionHelper.getFirebaseAuthExceptionMessage(e.code) ??
            e.message ??
            'Something went wrong',
      ));
    } on Exception catch (e) {
      emit(AuthStateAuthFailed(e, ExceptionHelper.getExceptionMessage(e)));
    }
  }

  Future<void> registerUser(User user, String password) async {
    try {
      emit(const AuthStateLoading());
      await authService
          .registerUser(
            user,
            password,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Timeout'),
          );
    } on auth.FirebaseAuthException catch (e) {
      emit(AuthStateAuthFailed(
        e,
        ExceptionHelper.getFirebaseAuthExceptionMessage(e.code) ??
            e.message ??
            'Something went wrong',
      ));
    } on Exception catch (e) {
      emit(AuthStateAuthFailed(e, ExceptionHelper.getExceptionMessage(e)));
    }
  }
}
