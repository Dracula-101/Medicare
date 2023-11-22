import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';

class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  State<PatientHomeView> createState() => PatientHomeViewState();
}

class PatientHomeViewState extends State<PatientHomeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription History',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return state.medicines.isEmpty
                  ? const Text('No Prescription')
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.medicines.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/pill.svg',
                            height: 30,
                            width: 30,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          minLeadingWidth: 0,
                          title: Text(state.medicines[index].medicine ?? '', overflow: TextOverflow.fade,maxLines: 1),
                          subtitle: Text(
                              '${state.medicines[index].days?.length} days'),
                        );
                      },
                    );
            },
          ),
          const Divider(
            thickness: 2,
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Upcoming Prescriptions',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.medicines.isEmpty
                      ? const Text('No Prescription')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.medicines.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                Icons.medication,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              minLeadingWidth: 0,
                              title: Text(
                                state.medicines[index]?.medicine ?? '',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    state.medicines[index].isMorning
                                        ? Icon(
                                            Icons.sunny,
                                            color: getMedicationColor(
                                                const TimeOfDay(
                                              hour: 8,
                                              minute: 0,
                                            )),
                                          )
                                        : const SizedBox(),
                                    AppSpacing.horizontalSpacing10,
                                    state.medicines[index].isAfternoon
                                        ? Icon(
                                            Icons.wb_sunny,
                                            color: getMedicationColor(
                                              const TimeOfDay(
                                                hour: 12,
                                                minute: 0,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    AppSpacing.horizontalSpacing10,
                                    state.medicines[index].isEvening
                                        ? Icon(
                                            Icons.nightlight_round,
                                            color: getMedicationColor(
                                              const TimeOfDay(
                                                hour: 18,
                                                minute: 0,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    const Spacer(),
                                    // S M T W T F S
                                    ...["M", "T", "W", "T", "F", "S", "S"].map(
                                      (e) => Container(
                                        width: 20,
                                        height: 20,
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          color: DateTime.now().weekday >=
                                                  [
                                                        "M",
                                                        "T",
                                                        "W",
                                                        "T",
                                                        "F",
                                                        "S",
                                                        "S",
                                                      ].indexOf(e) +
                                                      1
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Color getMedicationColor(TimeOfDay time) {
    final now = TimeOfDay.now();
    if (now.hour > time.hour) {
      return Colors.red;
    } else if (now.hour == time.hour) {
      if (now.minute > time.minute) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } else {
      return Colors.green;
    }
  }
}
