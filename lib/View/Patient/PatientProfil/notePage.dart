import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/Note/note.dart';

import '../../../Models/Patients/Patient.dart';
import '../../../Utils/values.dart';

class NotePage extends StatefulWidget {
  Patient patient;
  NotePage({Key key, this.patient}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.white,
      appBar: AppBar(
        backgroundColor: HelpitalColors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          HelpitalAssets.HELPITAL,
          scale: 10,
        ),
      ),
      body: Note(patient: widget.patient,)
    );
  }
}
