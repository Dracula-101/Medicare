import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/features/auth/bloc/cubit/auth_cubit.dart';
import 'package:medicare/features/auth/view/login_view.dart';
import 'package:medicare/services/auth_service/auth_service.dart';

import 'register_view.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        authService: GetIt.I.get<AuthService>(),
      ),
      child: const Scaffold(body: SafeArea(child: AuthView())),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  bool isLoginPage = true;
  AnimationController? _slideAnimationController;
  Animation<double>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _slideAnimationController!,
        curve: Curves.easeInExpo,
      ),
    );
  }

  @override
  void dispose() {
    _slideAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimationController!,
      builder: (context, child) {
        return Stack(
          children: [
            LoginView(
              onPageChange: () {
                _slideAnimationController?.forward();
              },
            ),
            Transform.translate(
              offset: Offset(
                0,
                MediaQuery.of(context).size.height *
                    (_slideAnimation?.value ?? 1),
              ),
              child: RegisterView(
                onPageChange: () {
                  _slideAnimationController?.reverse();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
