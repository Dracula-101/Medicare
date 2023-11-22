import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/features/auth/bloc/cubit/auth_cubit.dart';
import 'package:medicare/theme/colors.dart';
import 'package:medicare/util/helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicare/widgets/value_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.onPageChange});
  final VoidCallback onPageChange;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool? isCorrectName;
  bool? isCorrectEmail;
  bool? isCorrectPassword;
  bool? isAgeEntered;
  bool? isGenderEntered;
  bool? isHeightEntered;
  bool? isWeightEntered;
  bool isVisiblePassword = false;
  bool isPatientLogin = true;
  String? registerError;
  // email key
  final GlobalKey<FormFieldState<String>> emailKey =
      GlobalKey<FormFieldState<String>>();
  // password key
  final GlobalKey<FormFieldState<String>> passwordKey =
      GlobalKey<FormFieldState<String>>();
  //name key
  final GlobalKey<FormFieldState<String>> nameKey =
      GlobalKey<FormFieldState<String>>();

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime? birthDate;
  String? gender;
  double? height, weight;
  String doctorId = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalSpacing4,
              Text(
                'Create Account',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              AppSpacing.verticalSpacing8,
              Text(
                'Start learning by creating an account',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey300,
                    ),
              ),
              AppSpacing.verticalSpacing16,
              Center(
                child: CupertinoSlidingSegmentedControl<bool>(
                  groupValue: isPatientLogin,
                  children: const <bool, Widget>{
                    true: Text('Patient'),
                    false: Text('Doctor'),
                  },
                  onValueChanged: (bool? value) {
                    setState(() {
                      isPatientLogin = value ?? false;
                    });
                  },
                ),
              ),
              AppSpacing.verticalSpacing16,
              AnimatedContainer(
                height: (isCorrectEmail != null && isCorrectPassword != null) ||
                        registerError != null
                    ? 55
                    : 0,
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: (isCorrectEmail != null && isCorrectPassword != null) ||
                        registerError != null
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 35,
                          ),
                          AppSpacing.horizontalSpacing8,
                          if (registerError != null)
                            Flexible(
                              child: Text(
                                registerError!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            )
                          else if ((isCorrectName == null ||
                                  isCorrectEmail == null ||
                                  isCorrectPassword == null ||
                                  isAgeEntered == null ||
                                  isGenderEntered == null ||
                                  isHeightEntered == null ||
                                  isWeightEntered == null) ||
                              (isCorrectName! == false ||
                                  isCorrectEmail! == false ||
                                  isCorrectPassword! == false ||
                                  isAgeEntered! == false ||
                                  isGenderEntered! == false ||
                                  isHeightEntered! == false ||
                                  isWeightEntered! == false))
                            ErrorWidget(
                              isCorrectName: isCorrectName,
                              isCorrectEmail: isCorrectEmail,
                              isCorrectPassword: isCorrectPassword,
                              isGenderEntered: isGenderEntered,
                              isAgeEntered: isAgeEntered,
                              isHeightEntered: isHeightEntered,
                              isWeightEntered: isWeightEntered,
                            )
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
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        key: nameKey,
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: isCorrectName != null
                              ? isCorrectName!
                                  ? const Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.green,
                                    )
                                  : Icon(
                                      Icons.cancel_outlined,
                                      color:
                                          Theme.of(context).colorScheme.error,
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
                              isCorrectName = null;
                            });
                          }
                        },
                        validator: (value) {
                          bool isCorrectName = value != null &&
                              value.isNotEmpty &&
                              value.length >= 6;
                          setState(() {
                            this.isCorrectName = isCorrectName;
                          });
                          if (isCorrectName) {
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    birthDate = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8),
                                border: (isAgeEntered != null)
                                    ? isAgeEntered!
                                        ? null
                                        : Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          )
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.cakeCandles,
                                        color: AppColors.grey300,
                                      ),
                                      AppSpacing.horizontalSpacing10,
                                      Text('Age'),
                                    ],
                                  ),
                                  if (birthDate != null)
                                    Text(
                                      '${DateTime.now().difference(birthDate!).inDays ~/ 365} yrs',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomValuePicker(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  values: const ['Male', 'Female', 'Other'],
                                  title: 'Select your Gender',
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    gender = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8),
                                border: (isGenderEntered != null)
                                    ? isGenderEntered!
                                        ? null
                                        : Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          )
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.genderless,
                                        color: AppColors.grey300,
                                      ),
                                      AppSpacing.horizontalSpacing10,
                                      Text('Gender'),
                                    ],
                                  ),
                                  if (gender != null)
                                    gender == 'Male'
                                        ? Icon(
                                            Icons.male_rounded,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : gender == 'Female'
                                            ? Icon(
                                                Icons.female_rounded,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : Icon(
                                                FontAwesomeIcons.transgender,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalSpacing16,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomValuePicker(
                                  values: [
                                    for (var i = 1; i <= 250; i++) i.toString()
                                  ],
                                  title: 'Enter your weight (in kg)',
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    weight = double.tryParse(value);
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8),
                                border: (isWeightEntered != null)
                                    ? isWeightEntered!
                                        ? null
                                        : Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          )
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.weightScale,
                                        color: AppColors.grey300,
                                      ),
                                      AppSpacing.horizontalSpacing8,
                                      Text('Weight'),
                                    ],
                                  ),
                                  if (weight != null)
                                    Text(
                                      '$weight kg',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomValuePicker(
                                  values: [
                                    for (var i = 1; i <= 250; i++) i.toString()
                                  ],
                                  title: 'Enter your height (in cms)',
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    height = double.tryParse(value);
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8),
                                border: (isHeightEntered != null)
                                    ? isHeightEntered!
                                        ? null
                                        : Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          )
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.rulerVertical,
                                        color: AppColors.grey300,
                                      ),
                                      Text('Height'),
                                    ],
                                  ),
                                  if (height != null)
                                    Text(
                                      '$height cms',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalSpacing8,
                    if (!isPatientLogin) ...[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Doctor Id',
                            prefixIcon:
                                const Icon(Icons.medical_services_outlined),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
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
                          autofillHints: const [AutofillHints.email],
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value == "") {
                              setState(() {
                                doctorId = value;
                              });
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
                    ],
                    AppSpacing.verticalSpacing8,
                    const Divider(
                      color: AppColors.grey100,
                      thickness: 2,
                    ),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
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
                            setState(() {
                              isCorrectEmail = true;
                            });
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
                      registerError = state.message;
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
                        onPressed: () async {
                          setState(() {
                            isGenderEntered = gender != null;
                            isAgeEntered = birthDate != null;
                            isHeightEntered = height != null;
                            isWeightEntered = weight != null;
                          });
                          if (formKey.currentState?.validate() ?? false) {
                            FocusScope.of(context).unfocus();
                            int age =
                                DateTime.now().difference(birthDate!).inDays ~/
                                    365;
                            await BlocProvider.of<AuthCubit>(context)
                                .registerUser(
                              User(
                                id: '0',
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                userType: isPatientLogin
                                    ? UserType.PATIENT
                                    : UserType.DOCTOR,
                                age: age,
                                gender: gender!,
                                height: height.toString(),
                                weight: weight.toString(),
                                doctorId: isPatientLogin
                                    ? null
                                    : emailController.text.trim(),
                              ),
                              passwordController.text.trim(),
                            );
                          }
                        },
                        child: Text(
                          'Register as ${isPatientLogin ? 'Patient' : 'Doctor'}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    'Already have a account?',
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
                      'Login',
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
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.isCorrectName,
    required this.isCorrectEmail,
    required this.isCorrectPassword,
    required this.isGenderEntered,
    required this.isAgeEntered,
    required this.isHeightEntered,
    required this.isWeightEntered,
  });

  final bool? isCorrectName;
  final bool? isCorrectEmail;
  final bool? isCorrectPassword;
  final bool? isGenderEntered;
  final bool? isAgeEntered;
  final bool? isHeightEntered;
  final bool? isWeightEntered;

  @override
  Widget build(BuildContext context) {
    List<String> errors = [];
    if (isCorrectName == null || isCorrectName == false) {
      errors.add('Name');
    }
    if (isCorrectEmail == null || isCorrectEmail == false) {
      errors.add('Email');
    }
    if (isCorrectPassword == null || isCorrectPassword == false) {
      errors.add('Password');
    }
    if (isAgeEntered == null || isAgeEntered == false) {
      errors.add('Age');
    }
    if (isGenderEntered == null || isGenderEntered == false) {
      errors.add('Gender');
    }
    if (isHeightEntered == null || isHeightEntered == false) {
      errors.add('Height');
    }
    if (isWeightEntered == null || isWeightEntered == false) {
      errors.add('Weight');
    }

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required fields',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          AppSpacing.verticalSpacing4,
          Flexible(
            child: Text(
              errors.join(' • '),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
