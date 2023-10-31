import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/features/home/home_page.dart';
import 'package:medicare/features/intro/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDirector extends StatelessWidget {
  const AppDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (prev, next) => prev.isFirstUse != next.isFirstUse,
      builder: (context, state) {
        final bool isFirstUse = state.isFirstUse;
        if (isFirstUse) {
          return const IntroPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
