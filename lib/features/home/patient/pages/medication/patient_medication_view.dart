import 'package:flutter/material.dart';

class PatientMedicationView extends StatefulWidget {
  const PatientMedicationView({super.key});

  @override
  State<PatientMedicationView> createState() => _PatientMedicationViewState();
}

class _PatientMedicationViewState extends State<PatientMedicationView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Medication'),
      ),
    );
  }
}
