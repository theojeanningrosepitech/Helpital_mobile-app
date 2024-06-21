import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Patients/File.dart';
import 'package:helpital_mobile_app/Models/Patients/Patient.dart';
import 'package:provider/provider.dart';

import '../../../../Services/patientService.dart';
import '../../../../Services/stateManagerPatient.dart';
import '../../../../Utils/values.dart';
import '../../../../Widgets/Buttons/mySelectorFilter.dart';
import '../../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../../Widgets/UtilsWidgets/myLoading.dart';
import 'PatientFileDetailsPage.dart';

class PatientFilesPage extends StatefulWidget {
  const PatientFilesPage({Key key}) : super(key: key);

  @override
  State<PatientFilesPage> createState() => _PatientFilesPageState();
}

class _PatientFilesPageState extends State<PatientFilesPage> {
  List<File> listfile;
  bool selectorFile = true;
  bool selectorArchive = false;
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          buildTopPage(context),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: buildFilter(),
          ),
          selectorFile ? buildCoreFiles() : buildCoreArchives(),
        ],

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
                    'voici vos fichiers et vos archives',
                    style: TextStyle(
                        fontSize: 20,
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
  Widget buildFilter() {
    return Wrap(
      children: [
      MySelectorFilter(
      name: 'Fichier',
      index: 0,
      isSelected: selectorFile,
      boxSelected: () {
        setState(() {
          selectorFile = !selectorFile;
          selectorArchive = !selectorArchive;
        });
      },

    ),
        MySelectorFilter(
          name: 'Archives',
          index: 1,
          isSelected: selectorArchive,
          boxSelected: () {
            setState(() {
              selectorFile = !selectorFile;
              selectorArchive = !selectorArchive;
            });
            //getCurrentFilter(Filter.appareilMedical);
          },

        ),
      ]
    );
  }

  Widget buildCoreFiles() {
    final Patient patient = (context.watch<StateManagerPatient>()).patient;

    return FutureBuilder(
      future: PatientService().getFilePatient(patient.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError) {
          return MyErrorWidget();
        } else {
          listfile = snapshot.data;
          return MyListBuilder(
            list: listfile,
            builder: (context, index) {
              return MyAnimationListBuilder(
                index: index,
                child: buildNoteBlock(listfile[index]),
              );
            },
          );
        }
      },
    );
  }
  Widget buildCoreArchives() {
    final Patient patient = (context.watch<StateManagerPatient>()).patient;

    return FutureBuilder(
      future: PatientService().getArchivePatient(patient.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError) {
          return MyErrorWidget();
        } else {
          listfile = snapshot.data;
          return MyListBuilder(
            list: listfile,
            builder: (context, index) {
              return MyAnimationListBuilder(
                index: index,
                child: buildNoteBlock(listfile[index]),
              );
            },
          );
        }
      },
    );
  }
  Widget buildNoteBlock(File file) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientFileDetailsPage(file: file)));
      },
      child: ListTile(
        title: Text(file.fileName),
        subtitle: Text(file.type),
        trailing: Text(file.modifyAt),
        //trailing: Text(note.creator.firstName),

      ),
    );
  }
}

