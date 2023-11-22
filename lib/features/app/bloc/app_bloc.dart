import 'dart:async';

import 'package:medicare/core/bloc_core/ui_status.dart';
import 'package:medicare/data/models/local_medicine/local_medicine.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/services/app_service/app_service.dart';
import 'package:medicare/services/auth_service/auth_service.dart';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/services/log_service/log_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AppService appService,
    required LogService logService,
    required AuthService authService,
    required LocalStorageService localStorageService,
  }) : super(const AppState()) {
    _appService = appService;
    _logService = logService;
    _authService = authService;
    _localStorageService = localStorageService;
    on<_Loaded>(_onLoaded);
    on<_DarkModeChanged>(_onDarkModeChanged);
    on<_DisableFirstUse>(_onDisableFirstUse);
    on<_UserChanged>(_onUserChanged);
    _authService.onAuthStateChanged.listen((User? user) {
      add(_UserChanged(user: user));
    });
    on<_AddMedicine>((event, emit) async {
      addMedicines(event.medicines, emit);
    });

    logService.i('AppBloc created');
  }

  late final AppService _appService;
  late final AuthService _authService;
  late final LogService _logService;
  late final LocalStorageService _localStorageService;

  FutureOr<void> _onLoaded(
    _Loaded event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: const UILoading(),
        ),
      );

      final bool darkMode = _appService.isDarkMode;
      final bool isFirstUse = _appService.isFirstUse;
      final User? user = _authService.currentUser;
      List<Object>? medicine = _localStorageService.getList(
        key: 'medicines',
        fromJson: (p0) => LocalMedicine.fromJson(p0 as Map<String, dynamic>),
      );
      List localMeds = medicine ?? <LocalMedicine>[];
      for (int i = 0; i < (localMeds.length ?? 0); i++) {
        for (int j = i + 1; j <( localMeds.length ?? 0); j++) {
          if ((localMeds[i] as LocalMedicine).medicine?.toLowerCase() ==
              (localMeds[j] as LocalMedicine).medicine?.toLowerCase() ){
            localMeds.removeAt(j);
          }
        }
      }
      _logService.i('Medicine: $medicine, ${medicine.runtimeType}');
      emit(
        state.copyWith(
          status: const UILoadSuccess(),
          isDarkMode: darkMode,
          isFirstUse: isFirstUse,
          user: user,
          medicines: localMeds.cast<LocalMedicine>(),
        ),
      );
    } catch (e, s) {
      _logService.e('AppBloc load failed', e, s);
      emit(
        state.copyWith(
          status: UILoadFailed(message: e.toString()),
        ),
      );
    }
  }

  FutureOr<void> _onDarkModeChanged(
    _DarkModeChanged event,
    Emitter<AppState> emit,
  ) async {
    final bool isDarkMode = !state.isDarkMode;
    await _appService.setIsDarkMode(darkMode: isDarkMode);
    emit(
      state.copyWith(
        isDarkMode: isDarkMode,
      ),
    );
  }

  FutureOr<void> _onDisableFirstUse(
    _DisableFirstUse event,
    Emitter<AppState> emit,
  ) async {
    if (state.isFirstUse) {
      await _appService.setIsFirstUse(isFirstUse: false);
      emit(
        state.copyWith(
          isFirstUse: false,
        ),
      );
    }
  }

  FutureOr<void> _onUserChanged(
    _UserChanged event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        user: event.user,
      ),
    );
  }

  Future<void> addMedicines(
    List<LocalMedicine> medicines,
    Emitter<AppState> emit,
  ) async {
    _localStorageService.addList(
      key: 'medicines',
      list: medicines,
      toJson: (p0) => (p0 as LocalMedicine).toJson(),
    );
    emit(
      state.copyWith(
        medicines: state.medicines + medicines,
      ),
    );
  }
}
