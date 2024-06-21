import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Patients/NoteModele.dart';
import 'package:helpital_mobile_app/Services/patientService.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/PatientNotePages/PatientNoteDetailsPage.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:provider/provider.dart';

import '../../../../Models/Patients/Patient.dart';
import '../../../../Services/stateManagerPatient.dart';
import '../../../../Utils/values.dart';
import '../../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../../Widgets/UtilsWidgets/myListBuilder.dart';

class PatientNotePage extends StatefulWidget {
  const PatientNotePage({Key key}) : super(key: key);

  @override
  State<PatientNotePage> createState() => _PatientNotePageState();
}

class _PatientNotePageState extends State<PatientNotePage> {
  List<NoteModele> listNotes;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          buildTopPage(context),
          buildCore()
        ],
      ),
    );
  }

  Widget buildTopPage(BuildContext context) {
    final Patient patient = context.watch<StateManagerPatient>().patient;
    return Container(
        height: SizeCustom().assignHeight(context: context, fraction: 0.2),
        color: HelpitalColors.myColorPrimary,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(
              width: SizeCustom().assignWidth(context: context, fraction: 0.7),
              child: Wrap(
                children: [
                  Text(
                    'Bonjour ${patient.firstname},',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 30,
                        color: HelpitalColors.white
                    ),
                  ),
                  Text(
                    'voici les différents notes que le personnel de l\'hopital vous ont laissé',
                    style: TextStyle(
                        fontSize: 19,
                        color: HelpitalColors.myColorTextGreyClair

                    ),
                  ),

                ],
              ),
            ),
            Image.asset(HelpitalAssets.HELPITAL_WHITE,
              height: SizeCustom().assignWidth(context: context, fraction: 0.17),
              width: SizeCustom().assignWidth(context: context, fraction: 0.17),
            ),

          ],
        )
    );
  }
  Widget buildCore() {
    final Patient patient = (context.watch<StateManagerPatient>()).patient;

    return FutureBuilder(
      future: PatientService().getNotePatient(patient.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError) {
          return MyErrorWidget();
        } else {
          listNotes = snapshot.data;
          return MyListBuilder(
            list: listNotes,
            builder: (context, index) {
              return MyAnimationListBuilder(
                index: index,
                child: buildNoteBlock(listNotes[index]),
              );
            },
          );
        }
      },
    );
  }
  Widget buildNoteBlock(NoteModele note) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientNoteDetailsPage(note: note)));
      },
      child: ListTile(
        title: Text(note.content),
        trailing: Text(note.creator.firstName != null ?  note.creator.firstName : 'Doctor'),
        //trailing: Text(note.creator.firstName),

      ),
    );
  }
}
