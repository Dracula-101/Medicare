import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/features/home/patient/pages/home/patient_home_page.dart';
import 'package:medicare/features/home/patient/pages/medication/patient_medication_view.dart';
import 'package:medicare/features/home/patient/pages/profile/patient_profile_view.dart';
import 'package:medicare/features/home/patient/pages/search/patient_search_view.dart';
import 'package:medicare/router/app_router.dart';
import 'package:medicare/services/auth_service/auth_service.dart';
import 'package:medicare/theme/app_theme.dart';
import 'package:medicare/theme/colors.dart';

class PatientMainPage extends StatefulWidget {
  const PatientMainPage({super.key});

  @override
  State<PatientMainPage> createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientMainPage> {
  User? patientUser;
  int currentPage = 0;

  List<Widget>? screenWidgets = [];

  @override
  void initState() {
    super.initState();
    patientUser = GetIt.I.get<AuthService>().currentUser;
    screenWidgets = [
      const PatientHomeView(),
      const PatientSearch(),
      const PatientMedicationView(),
      PatientProfileView(
        patient: patientUser!,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouter.ocrPath);
        },
        child: const Icon(FontAwesomeIcons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => currentPage = value),
        currentIndex: currentPage,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.tertiary,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home.svg',
              height: 20,
              width: 20,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/home.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/search.svg',
              height: 20,
              width: 20,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/search.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/calendar.svg',
              height: 20,
              width: 20,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/calendar.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Medication',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/user.svg',
              height: 20,
              width: 20,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/user.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (currentPage != 3)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                sliver: SliverAppBar(
                  leading: Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 2,
                        ),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [boxShadow()],
                        image: patientUser?.avatar.isEmpty ?? true
                            ? null
                            : DecorationImage(
                                image: NetworkImage(patientUser!.avatar),
                                fit: BoxFit.cover,
                              )),
                    child: patientUser?.avatar.isEmpty ?? true
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  titleSpacing: 5,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientUser?.name ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.grey200,
                            ),
                      ),
                    ],
                  ),
                  actions: [
                    //settings
                    Badge(
                      label: const Text('1'),
                      isLabelVisible: true,
                      offset: const Offset(-6, 7),
                      child: IconButton(
                        onPressed: () {
                          // use gorouter
                        },
                        icon: const Icon(FontAwesomeIcons.solidBell),
                        splashRadius: 20,
                      ),
                    )
                  ],
                ),
              )
            else
              SliverAppBar(
                title: Text('Profile',
                    style: Theme.of(context).textTheme.titleMedium),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.solidEnvelope),
                  )
                ],
              ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (currentPage == 0)
                    screenWidgets![0]
                  else if (currentPage == 1)
                    screenWidgets![1]
                  else if (currentPage == 2)
                    screenWidgets![2]
                  else
                    screenWidgets![3]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
