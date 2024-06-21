import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Models/Patients/File.dart';
import '../../../../Widgets/PatternPages/pageSettingsDefault.dart';

class PatientFileDetailsPage extends StatefulWidget {
  File file;
  PatientFileDetailsPage({this.file});

  @override
  State<PatientFileDetailsPage> createState() => _PatientFileDetailsPageState();
}

class _PatientFileDetailsPageState extends State<PatientFileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
        name: widget.file.fileName,
        child: Center(
          child: Text(
              widget.file.content
          ),
        ),
    );
  }
}
