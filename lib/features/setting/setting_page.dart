import 'package:medicare/core/dimens/app_dimens.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppDimens.basePadding),
        child: Column(
          children: [
            AppSpacing.verticalSpacing24,
            _DarkModeRow(),
          ],
        ),
      ),
    );
  }
}

class _DarkModeRow extends StatelessWidget {
  const _DarkModeRow();

  @override
  Widget build(BuildContext context) {
    final bool darkMode =
        context.select((AppBloc bloc) => bloc.state.isDarkMode);
    return SwitchListTile(
      value: darkMode,
      onChanged: (value) {
        context.read<AppBloc>().add(const AppEvent.darkModeChanged());
      },
      title: Text('Dark Mode'),
    );
  }
}
