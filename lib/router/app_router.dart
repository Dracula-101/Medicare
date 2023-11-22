import 'package:medicare/features/app/view/app_director.dart';
import 'package:medicare/features/home/patient/pages/medication/patient_medication_selection_view.dart';
import 'package:medicare/features/setting/setting_page.dart';
import 'package:medicare/features/home/patient/pages/ocr/ocr_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const String appDirector = 'appDirector';
  static const String appDirectorPath = '/';

  static const String patientHomeNamed = 'patientHome';
  static const String patientHomePath = '/';
  static const String doctorHomeNamed = 'doctorHome';
  static const String doctorHomePath = '/';

  static const String settingNamed = 'setting';
  static const String settingPath = '/setting';

  static const String assetsNamed = 'assets';
  static const String assetsPath = '/assets';

  static const String dogImageRandomNamed = 'dogImageRandom';
  static const String dogImageRandomPath = '/dogImageRandom';

  static const String imagesFromDbNamed = 'imagesFromDb';
  static const String imagesFromDbPath = '/imagesFromDb';

  static const String ocrNamed = 'ocr';
  static const String ocrPath = '/ocr';

  static const String medicationSelectedNamed = 'medicationSelected';
  static const String medicationSelectedPath = '/medicationSelected';

  static GoRouter get router => _router;
  static final _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: appDirector,
        path: appDirectorPath,
        builder: (context, state) {
          return const AppDirector();
        },
      ),
      GoRoute(
        name: ocrNamed,
        path: ocrPath,
        builder: (context, state) => const OCRView(),
      ),
      GoRoute(
        name: settingNamed,
        path: settingPath,
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        name: medicationSelectedNamed,
        path: medicationSelectedPath,
        builder: (context, state) =>
            MedicationSelectionView(medicine: state.extra as List<String>),
      )
    ],
  );
}
