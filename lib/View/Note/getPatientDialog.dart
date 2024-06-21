
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/Patients/Patient.dart';
import '../../Services/patientService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../Widgets/UtilsWidgets/myLoading.dart';
import '../../Widgets/mySearchingBar.dart';

class GetPatientDialog extends StatefulWidget {

  Function(Patient) patientSelected;
  GetPatientDialog({Key key, this.patientSelected}) : super(key: key);

  @override
  _GetPatientDialogState createState() => _GetPatientDialogState(
      patientSelected: patientSelected
  );
}

class _GetPatientDialogState extends State<GetPatientDialog> {

  Function(Patient) patientSelected;
  _GetPatientDialogState({this.patientSelected});
  List<Patient> listPatient;
  String query;

  void setListofSearch(String value) {
    List<Patient> bufferSearch = [];
    if (value != null) {

      listPatient.forEach((element) {
        if (element.lastname.contains(value)) {
          bufferSearch.add(element);
        } else if (element.firstname.contains(value)) {
          bufferSearch.add(element);
        }


      });
      listPatient = bufferSearch;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selectioné un patient'),
      content: buildCore(context),
    );
  }

  Widget buildCore(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height*0.8,
      width: size.width*0.8,

      child: Column(
        children: [
          MySearchingBar(
            currentInput: (value) {
              if (listPatient != null) {
                setState(() {
                  query = value;

                });
              }
            },
          ),
          Flexible(
              child: Container(
                  height: size.height*0.8,
                  child: FutureBuilder(
                    future: PatientService().getPatients(),
                    initialData: 0,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyLoading();
                      }
                      if (snapshot.hasError) {
                        return MyErrorWidget();
                      } else {
                        listPatient = snapshot.data;
                        setListofSearch(query);
                        return MyListBuilder(
                          list: listPatient,
                          builder: (context, index) {
                            return MyAnimationListBuilder(
                                index: index,
                                child: buildPatientElement(listPatient[index])
                            );
                          },
                        );
                      }
                    },
                  )
              )
          )
        ],
      ),
    );
  }

  Widget buildPatientElement(Patient patient) {

    return InkWell(
        onTap: () {
          patientSelected(patient);
          Navigator.pop(context);

        },
        child: ListTile(
          title: Text('${patient.firstname} ${patient.lastname}') ,
        )
    );
  }


}