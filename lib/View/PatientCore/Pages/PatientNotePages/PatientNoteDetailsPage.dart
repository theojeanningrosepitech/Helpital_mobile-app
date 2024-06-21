import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Models/Patients/NoteModele.dart';
import '../../../../Widgets/PatternPages/pageSettingsDefault.dart';

class PatientNoteDetailsPage extends StatefulWidget {
  NoteModele note;
  PatientNoteDetailsPage({this.note});

  @override
  State<PatientNoteDetailsPage> createState() => _PatientNoteDetailsPageState();
}

class _PatientNoteDetailsPageState extends State<PatientNoteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
      name: widget.note.creator.firstName != null ?  widget.note.creator.firstName : 'Doctor',
      child: Center(
        child: Text(
            widget.note.content
        ),
      ),
    );
  }
}
