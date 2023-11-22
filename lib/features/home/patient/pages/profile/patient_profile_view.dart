import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/services/auth_service/auth_service.dart';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/theme/app_theme.dart';
import 'package:medicare/theme/colors.dart';

class PatientProfileView extends StatefulWidget {
  const PatientProfileView({super.key, required this.patient});
  final User patient;

  @override
  State<PatientProfileView> createState() => _PatientProfileViewState();
}

class _PatientProfileViewState extends State<PatientProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PatientProfileWidget(
          patient: widget.patient,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [cardShadow()],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    context.read<AppBloc>().state.isDarkMode
                        ? Icon(
                            FontAwesomeIcons.moon,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : Icon(
                            FontAwesomeIcons.sun,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    AppSpacing.horizontalSpacing16,
                    Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: context.read<AppBloc>().state.isDarkMode,
                    onChanged: (value) {
                      context
                          .read<AppBloc>()
                          .add(const AppEvent.darkModeChanged());
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSpacing.verticalSpacing20,
        SettingsDetailsWidget(
          title: 'Medical History',
          subtitle: 'Check all your medical history',
          icon: SvgPicture.asset(
            'assets/svg/book_info.svg',
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        AppSpacing.verticalSpacing20,
        SettingsDetailsWidget(
          title: '${widget.patient.name.split(" ")[0]}\'s History',
          subtitle: 'Receive and save up. Points to receive a gifts!',
          icon: SvgPicture.asset(
            'assets/svg/patient_user.svg',
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        AppSpacing.verticalSpacing20,
        SettingsWidget(
          title: 'Medication',
          icon: SvgPicture.asset(
            'assets/svg/pill.svg',
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        AppSpacing.verticalSpacing20,
        SettingsWidget(
          title: 'Personal Information',
          icon: SvgPicture.asset(
            'assets/svg/home_user.svg',
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        AppSpacing.verticalSpacing20,
        SettingsWidget(
          onTap: () {},
          title: 'Profile Settings',
          icon: Icon(
            FontAwesomeIcons.gear,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        AppSpacing.verticalSpacing20,
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                content: Text(
                  'Are you sure you want to logout?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: ()async {
                      await GetIt.I.get<LocalStorageService>().clear();
                      Navigator.pop(context);
                      GetIt.I.get<AuthService>().signOut();
                    },
                    child: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text(
            'Logout',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        AppSpacing.verticalSpacing48,
      ],
    );
  }
}

class PatientProfileWidget extends StatelessWidget {
  const PatientProfileWidget({
    super.key,
    required this.patient,
  });

  final User patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [boxShadow()],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.userCheck,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    image: patient.avatar.isEmpty
                        ? null
                        : DecorationImage(
                            image: NetworkImage(patient.avatar),
                            fit: BoxFit.cover,
                          ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                AppSpacing.horizontalSpacing16,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        patient.email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey300,
                            ),
                      ),
                      AppSpacing.verticalSpacing10,
                      Row(
                        children: [
                          Text(
                            '${patient.age} ${patient.gender} • ${patient.weight} kg • ${patient.height} cm',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.grey400,
                                    ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget(
      {super.key, required this.title, required this.icon, this.onTap});

  final String title;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onTap?.call(),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [cardShadow()],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    icon,
                    AppSpacing.horizontalSpacing16,
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsDetailsWidget extends StatelessWidget {
  const SettingsDetailsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onTap?.call(),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [cardShadow()],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        icon,
                        AppSpacing.horizontalSpacing16,
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Read',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          AppSpacing.horizontalSpacing16,
                          Icon(
                            FontAwesomeIcons.arrowRight,
                            size: 12,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                AppSpacing.verticalSpacing10,
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey400,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
