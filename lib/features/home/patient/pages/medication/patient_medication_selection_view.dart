import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/data/models/local_medicine/local_medicine.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/services/notification_service/local_notification_service.dart';
import 'package:medicare/widgets/back_button.dart';


class MedicationSelectionView extends StatefulWidget {
  final List<String>? medicine;
  const MedicationSelectionView({super.key, required this.medicine});

  @override
  State<MedicationSelectionView> createState() =>
      _MedicationSelectionViewState();
}

class _MedicationSelectionViewState extends State<MedicationSelectionView> {
  TextEditingController _medicineController = TextEditingController();
  List<LocalMedicine> medicine = [];
  final LocalNotificationService _localNotificationService =
      GetIt.instance.get<LocalNotificationService>();
  @override
  void initState() {
    super.initState();
    medicine = widget.medicine?.map((e) => LocalMedicine(medicine: e)).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Medicine'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Medicine'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _medicineController,
                    decoration: const InputDecoration(
                      hintText: 'Medicine Name',
                    ),
                    autofocus: true,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    widget.medicine?.add(_medicineController.text);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Medication',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Organize Medicines',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            if (widget.medicine?.isNotEmpty ?? false)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.medicine?.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(widget.medicine![index]),
                    initiallyExpanded: true,
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    children: [
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: [
                          ...['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                              .map(
                            (e) => ChoiceChip(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              label: Text(
                                e,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              selected: medicine[index].days?.contains(e) ?? false,
                              selectedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              onSelected: (value) {
                                List<String> days = medicine[index].days ?? [];
                                setState(() {
                                  if (medicine[index].days?.contains(e) ??
                                      false) {
                                    days.remove(e);
                                    medicine[index] = medicine[index]
                                      ..days = days;
                                  } else {
                                    days.add(e);
                                    medicine[index] = medicine[index]
                                      ..days = days;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.verticalSpacing6,
                      const Text('Time'),
                      AppSpacing.verticalSpacing6,
                      Wrap(
                        // time
                        spacing: 8,
                        children: [
                          ...['Morning (10am)', 'Afternoon (12pm)', 'Evening (5pm)'].map(
                            (e) => ChoiceChip(
                              label: Text(
                                e,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              selected: e == 'Morning (10am)'
                                  ? medicine[index].isMorning
                                  : e == 'Afternoon (12pm)'
                                      ? medicine[index].isAfternoon
                                      : medicine[index].isEvening,
                              selectedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              onSelected: (value) {
                                setState(() {
                                  if (e == 'Morning (10am)') {
                                    medicine[index].isMorning =
                                        !medicine[index].isMorning;
                                  } else if (e == 'Afternoon (12pm)') {
                                    medicine[index].isAfternoon =
                                        !medicine[index].isAfternoon;
                                  } else if (e == 'Evening (5pm)') {
                                    medicine[index].isEvening =
                                        !medicine[index].isEvening;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            Container(
              // save
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  widget.medicine?.forEach((element) {
                    medicine.add(
                      LocalMedicine(
                        medicine: element,
                        days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        isAfternoon: true,
                        isMorning: true,
                        isEvening: true,
                      ),
                    );
                  });
                  // remove duplicates
                  medicine = medicine.toSet().toList();
                  context
                      .read<AppBloc>()
                      .add(AppEvent.addMedicines(medicines: medicine));
                  // tell user that medicine has been added via notification
                  String message = "";
                  for (var element in medicine) {
                    message += "${element.medicine!}\nDays: ${element.days?.join(', ')}\n\n";
                  }

                  await _localNotificationService.showNotification(
                    'Medicine${medicine.length > 1 ? 's' : ''} Added',
                    message,
                    'Medicine Added',
                  );
                  // schedule notification
                  for (var element in medicine) {
                    if (element.isMorning) {
                      _localNotificationService.scheduleDailyNotification(
                        element.medicine!,
                        'Time to take your medicine',
                        element.medicine!,
                        const Duration(hours: 10),
                      );
                    }
                    if (element.isAfternoon) {
                      _localNotificationService.scheduleDailyNotification(
                        element.medicine!,
                        'Time to take your medicine',
                        element.medicine!,
                        const Duration(hours: 12),
                      );
                    }
                    if (element.isEvening) {
                      _localNotificationService.scheduleDailyNotification(
                        element.medicine!,
                        'Time to take your medicine',
                        element.medicine!,
                        const Duration(hours: 17),
                      );
                    }
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ),
            AppSpacing.verticalSpacing48,
            AppSpacing.verticalSpacing48,
          ],
        ),
      ),
    );
  }
}
