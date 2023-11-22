import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/features/auth/bloc/cubit/auth_cubit.dart';
import 'package:medicare/services/notification_service/local_notification_service.dart';
import 'package:medicare/theme/colors.dart';
import 'package:medicare/util/helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.onPageChange});
  final VoidCallback onPageChange;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? isCorrectEmail;
  bool? isCorrectPassword;
  bool isVisiblePassword = false;
  String? loginError;
  // email key
  final GlobalKey<FormFieldState<String>> emailKey =
      GlobalKey<FormFieldState<String>>();
  // password key
  final GlobalKey<FormFieldState<String>> passwordKey =
      GlobalKey<FormFieldState<String>>();

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      GetIt.instance.get<LocalNotificationService>().requestNotificationPermission();
    });
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.verticalSpacing4,
            Text(
              'Login Account',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            AppSpacing.verticalSpacing8,
            Text(
              'Please login with registered account',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey300,
                  ),
            ),
            AppSpacing.verticalSpacing4,
            AnimatedContainer(
              height: !(isCorrectEmail ?? true) ||
                      !(isCorrectPassword ?? true) ||
                      (loginError != null)
                  ? 35
                  : 0,
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: !(isCorrectEmail ?? true) ||
                      !(isCorrectPassword ?? true) ||
                      (loginError != null)
                  ? Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        AppSpacing.horizontalSpacing8,
                        if (loginError != null)
                          Flexible(
                            child: Text(
                              loginError!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          )
                        else if (!isCorrectEmail! && isCorrectPassword!)
                          Text(
                            'Please enter a valid email',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        else if (isCorrectEmail! && !isCorrectPassword!)
                          Text(
                            'Please enter a valid password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        else if (!isCorrectEmail! && !isCorrectPassword!)
                          Text(
                            'Please enter a valid email and password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  AppSpacing.verticalSpacing8,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      key: emailKey,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: isCorrectEmail != null
                            ? isCorrectEmail!
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    color: Theme.of(context).colorScheme.error,
                                  )
                            : null,
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 0,
                          height: 0.001,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: null,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primary,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      onChanged: (value) {
                        if (value == "") {
                          setState(() {
                            isCorrectEmail = null;
                          });
                        }
                      },
                      validator: (value) {
                        bool isCorrectEmail =
                            HelperFunction.verifyEmail(value ?? '');
                        setState(() {
                          this.isCorrectEmail = isCorrectEmail;
                        });
                        if (isCorrectEmail) {
                          return null;
                        } else {
                          return 'Please enter a valid email';
                        }
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  AppSpacing.verticalSpacing16,
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  AppSpacing.verticalSpacing8,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      key: passwordKey,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_person_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          splashRadius: 10,
                          color: isCorrectPassword != null
                              ? isCorrectPassword!
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                          icon: isVisiblePassword
                              ? const Icon(
                                  Icons.visibility_outlined,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                ),
                          onPressed: () {
                            setState(() {
                              isVisiblePassword = !isVisiblePassword;
                            });
                          },
                        ),
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 0,
                          height: 0.001,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorText: null,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primary,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.password],
                      obscureText: !isVisiblePassword,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      validator: (value) {
                        bool isCorrectPassword = value != null &&
                            value.isNotEmpty &&
                            value.length >= 6;
                        setState(() {
                          this.isCorrectPassword = isCorrectPassword;
                        });
                        if (isCorrectPassword) {
                          return null;
                        } else {
                          return 'Please enter a valid password';
                        }
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSpacing16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey300,
                        ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpacing16,
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthStateAuthFailed) {
                  setState(() {
                    loginError = state.message;
                  });
                } else if (state is AuthStateLoading) {
                  setState(() {
                    loginError = null;
                  });
                }
              },
              builder: (context, state) {
                if (state is AuthStateLoading) {
                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<AuthCubit>(context).signInWithEmail(
                            emailController.text
                                .trim()
                                .toLowerCase()
                                .toString(),
                            passwordController.text.trim().toString(),
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  );
                }
              },
            ),
            AppSpacing.verticalSpacing4,
            const Divider(
              color: AppColors.grey200,
              thickness: 1,
            ),
            AppSpacing.verticalSpacing16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or login with',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey300,
                      ),
                ),
              ],
            ),
            AppSpacing.verticalSpacing16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                  },
                  customBorder: const CircleBorder(),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.grey200,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/281/281764.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpacing32,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey300,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onPageChange();
                  },
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
