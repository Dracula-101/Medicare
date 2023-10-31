import 'package:flutter/services.dart';
import 'package:medicare/core/bloc_core/ui_status.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/router/app_router.dart';
import 'package:medicare/theme/app_theme.dart';
import 'package:medicare/widgets/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicareApp extends StatefulWidget {
  const MedicareApp({super.key});

  @override
  State<MedicareApp> createState() => _MedicareAppState();
}

class _MedicareAppState extends State<MedicareApp> {
  late final AppBloc _appBloc;

  @override
  void initState() {
    _appBloc = Injector.instance<AppBloc>()
      ..add(
        const AppEvent.loaded(),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>.value(
      value: _appBloc,
      child: BlocSelector<AppBloc, AppState, UIStatus>(
        bloc: _appBloc,
        selector: (state) => state.status,
        builder: (context, appStatus) {
          return appStatus.when(
            initial: () => const SplashPage(),
            loading: () => const SplashPage(),
            loadFailed: (_) => const SizedBox(),
            loadSuccess: (_) => const _App(),
          );
        },
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.select(
      (AppBloc value) => value.state.isDarkMode,
    );
    return MaterialApp.router(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      routerConfig: AppRouter.router,
      title: 'Medicare App',
    );
  }
}
