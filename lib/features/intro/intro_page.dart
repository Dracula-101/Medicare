import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:medicare/core/keys/app_keys.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicare/theme/colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    // load lottie
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: _currentPage == 0 ? 0 : 1,
              child: _currentPage == 0
                  ? const SizedBox()
                  : InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.grey300,
                        ),
                        child: Text(
                          'Back',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  if (_currentPage == 3) {
                    context
                        .read<AppBloc>()
                        .add(const AppEvent.disableFirstUse());
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: _currentPage == 0 ? 0 : 8),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Next',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.verticalSpacing4,
                Text(
                  'Welcome to',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.grey300),
                ),
                Text(
                  'Medicare',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 45),
                  overflow: TextOverflow.fade,
                ),
                AppSpacing.verticalSpacing32,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      IntroPage1(),
                      IntroPage2(),
                      IntroPage3(),
                      IntroPage4(),
                    ],
                  ),
                ),
                AppSpacing.verticalSpacing16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _currentPage == index
                            ? Theme.of(context).primaryColor
                            : AppColors.grey300,
                      ),
                    ),
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

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: LottieBuilder.asset(
              'assets/lottie/Intro_1.json',
              repeat: true,
              reverse: true,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        AppSpacing.verticalSpacing4,
        Text(
          'Your personal Health app',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey800,
                fontWeight: FontWeight.w800,
              ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'Medicare is a mobile application that helps you to manage your health.',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.grey300),
        ),
      ],
    );
  }
}

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: LottieBuilder.asset(
              'assets/lottie/Intro_2.json',
              repeat: true,
              reverse: true,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        AppSpacing.verticalSpacing4,
        //medicin
        Text(
          'Medicine Prescription',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey800,
                fontWeight: FontWeight.w800,
              ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'Get Automatic Medicine Prescription from your doctor. Just upload your medical report and get your prescription.',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.grey300),
        ),
      ],
    );
  }
}

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: LottieBuilder.asset(
              'assets/lottie/Intro_3.json',
              repeat: true,
              reverse: true,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'Doctor Health Advise',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey800,
                fontWeight: FontWeight.w800,
              ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'Advice from your doctor. Get health advice from your doctor who are professional in their field.',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.grey300),
        ),
      ],
    );
  }
}

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: LottieBuilder.asset(
              'assets/lottie/Intro_4.json',
              repeat: true,
              reverse: true,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'Detailed Report Analysis',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey800,
                fontWeight: FontWeight.w800,
              ),
        ),
        AppSpacing.verticalSpacing8,
        Text(
          'After uploading your medical report, you will get detailed analysis of your report. You can also share your report with your doctor.',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.grey300),
        ),
      ],
    );
  }
}
