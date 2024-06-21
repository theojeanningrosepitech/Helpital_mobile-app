import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Patients/Prescription.dart';

import '../../../../Widgets/PatternPages/pageSettingsDefault.dart';


class PatientPrescriptionDetailsPage extends StatefulWidget {
  Prescription prescription;
  PatientPrescriptionDetailsPage({this.prescription});

  @override
  State<PatientPrescriptionDetailsPage> createState() => _PatientPrescriptionDetailsPageState();
}

class _PatientPrescriptionDetailsPageState extends State<PatientPrescriptionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
      name: widget.prescription.creatorLogin,
      child: Center(
        child: Text(
            widget.prescription.content
        ),
      ),
    );
  }
}
