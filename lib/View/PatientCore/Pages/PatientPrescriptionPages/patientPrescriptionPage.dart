import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/PatientPrescriptionPages/patientPrescriptionDetailsPage.dart';
import 'package:provider/provider.dart';

import '../../../../Models/Patients/NoteModele.dart';
import '../../../../Models/Patients/Patient.dart';
import '../../../../Models/Patients/Prescription.dart';
import '../../../../Services/patientService.dart';
import '../../../../Services/stateManagerPatient.dart';
import '../../../../Utils/values.dart';
import '../../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../../Widgets/UtilsWidgets/myLoading.dart';
import '../PatientNotePages/PatientNoteDetailsPage.dart';

class PatientPrescriptionPage extends StatefulWidget {
  const PatientPrescriptionPage({Key key}) : super(key: key);

  @override
  State<PatientPrescriptionPage> createState() => _PatientPrescriptionPageState();
}

class _PatientPrescriptionPageState extends State<PatientPrescriptionPage> {
  List<Prescription> listPrescription;
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
                    'voici les différents prescriptions que les médecins vous ont laissé',
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
      future: PatientService().getPrescriptionPatient(patient.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError) {
          return MyErrorWidget();
        } else {
          listPrescription = snapshot.data;
          return MyListBuilder(
            list: listPrescription,
            builder: (context, index) {
              return MyAnimationListBuilder(
                index: index,
                child: buildNoteBlock(listPrescription[index]),
              );
            },
          );
        }
      },
    );
  }
  Widget buildNoteBlock(Prescription prescription) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientPrescriptionDetailsPage(prescription: prescription)));
      },
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HelpitalColors.myColorTextGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              )
          ),
          height: SizeCustom().assignHeight(context: context, fraction: 0.06),
          width: SizeCustom().assignWidth(context: context, fraction: 1),
          child: Center(
            child:  Text('Prescription de Mr ${listPrescription[0].creatorLogin}',
              style: TextStyle(color: HelpitalColors.white, fontSize: 20),
            ),
          )
      ),
    );
  }
}

