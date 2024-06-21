import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Note/stateDialog.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myCustomScrollView.dart';

import '../../Models/Patients/Patient.dart';
import '../../Services/noteService.dart';
import '../../Widgets/Buttons/myButtonContact.dart';
import 'getPatientDialog.dart';

class Note extends StatefulWidget {
  Patient patient;

  Note({Key key, this.patient = null}) : super(key: key);

  @override
  _NoteState createState() => _NoteState(
    patient: patient
  );
}

class _NoteState extends State<Note> {

  String note;
  Patient patient;
  _NoteState({this.patient});
  var controller = TextEditingController();
  var controllerNote = TextEditingController();
  List<String> list = <String>['Basse', 'Moyenne', 'Élevée', 'Trés élevée'];
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        body: MyCustomScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),

                buildPatientSelector(context),
                SizedBox(
                  height: 20,
                ),
                buildDropDownTypeOfPriority(context),
                SizedBox(
                  height: 10,
                ),
                builderContainerNote(context),

              ],
            ),
          ),
        )
    );
  }
  Widget buildPatientSelector(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: HelpitalColors.white,
      margin: EdgeInsets.all(12),
      height: size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButtonContact(
            icon: Icon(Icons.search, color: HelpitalColors.white,),
            color: HelpitalColors.myColorPrimary,

            onClick: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => GetPatientDialog(
                  patientSelected: (Patient _patientsSelected) {
                    setState(() {
                      patient = _patientsSelected;
                    });
                  },
                )
            ),),
          SizedBox(width: 1,),
          Container(
            width: size.width * 0.7,
            color: HelpitalColors.myColorTextGreyClair,
            child:   Container(
              decoration: BoxDecoration(
                color: HelpitalColors.white,

              ),
              width: double.infinity,
              padding: EdgeInsets.only(
                top: size.height * 0.017,
                bottom: size.height * 0.017,
                left: size.width * 0.06,
              ),
              //color: Colors.red,

              child: patient != null ? Text('${patient.firstname} ${patient.lastname}') : Text('selectioné un patient'),



            ),

          ),
          IconButton(
            icon: Icon(Icons.send, color: HelpitalColors.green,),
            color: HelpitalColors.white,

            onPressed: () async {

              bool result = await NoteService().setNote(patient, note, list.indexOf(dropdownValue));

              if (result) {
                setState(() {
                  note = '';
                  controllerNote.clear();
                  patient = null;
                });
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => StateDialog(
                      title:'Succée' ,
                      content: 'Votre note a été créer avec succée',
                      color: HelpitalColors.green,
                    )
                );
              } else {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => StateDialog(
                      title: 'Erreur',
                      content: 'Une erreur est surevenue',
                      color: HelpitalColors.red,
                    )
                );
              }
            }
            ,),

        ],
      ),
    );
  }

  Widget builderContainerNote(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: HelpitalColors.white,
      margin: EdgeInsets.all(12),
      height: size.height * 0.5,
      child: buildtextEditing(context),
    );
  }

  Widget buildDropDownTypeOfPriority(BuildContext context) {
    if (dropdownValue == null)
      dropdownValue = list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget buildtextEditing(BuildContext context) {
    var borderRadius = 30.0;

    return TextField(
      controller: this.controllerNote,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Écrivez votre note',
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        fillColor: HelpitalColors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HelpitalColors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),

      onChanged: (_note) {
        setState(() {
          this.note = _note;
        });
      },
    );
  }
}
