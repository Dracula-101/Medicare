import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/features/auth/view/auth.dart';
import 'package:medicare/features/home/doctor/doctor_main_view.dart';
import 'package:medicare/features/home/patient/patient_main_view.dart';
import 'package:medicare/features/intro/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDirector extends StatelessWidget {
  const AppDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          (previous.user?.id != current.user?.id) ||
          (previous.isFirstUse != current.isFirstUse),
      builder: (context, state) {
        final bool isFirstUse = state.isFirstUse;
        final isLoggedIn = state.user != null;
        if (isFirstUse && !isLoggedIn) {
          return const IntroPage();
        } else if (!isLoggedIn) {
          return const AuthScreen();
        } else {
          bool isPatient = state.user?.userType == UserType.PATIENT;
          if (isPatient) {
            return const PatientMainPage();
          } else {
            return const DoctorMainPage();
          }
        }
      },
    );
  }
}
