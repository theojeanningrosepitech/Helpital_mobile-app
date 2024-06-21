import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../Models/Patients/Patient.dart';
import '../../../../../Models/Rooms/Room.dart';
import '../../../../../Services/patientService.dart';
import '../../../../../Utils/values.dart';
import '../../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../../../Widgets/UtilsWidgets/myLoading.dart';
import '../../../../Note/stateDialog.dart';

class TransfertFree extends StatefulWidget {
  Patient patient;
  Room room;
  TransfertFree({Key key, this.patient, this.room}) : super(key: key);

  @override
  _TransfertFreeState createState() => _TransfertFreeState(
    currentPatient: patient,
    currentRoom: room
  );
}

class _TransfertFreeState extends State<TransfertFree> {

  Patient currentPatient;
  Room currentRoom;
  _TransfertFreeState({this.currentPatient, this.currentRoom});

  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
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
        body: Center(
          child: buildCore(context)
        )

    );
  }
  Widget buildCore(BuildContext context) {
    return Container(
      height: SizeCustom().assignHeight(context: context, fraction: 1),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: buildTitle(context)
          ),
          Expanded(
              flex: 3,
              child: buildInfoBlock(context)
          ),
          Expanded(
              flex: 3,
              child: buildCurrentPatientToThisRoom(context)
          ),
        ],
      ),
    );
  }
  Widget buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(currentRoom.title, style: TextStyle(fontSize: 30),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 1,),
            Text(currentRoom.service.title, style: TextStyle(fontSize: 25),),
            SizedBox(width: 1,),
            Text(currentRoom.type.title, style: TextStyle(fontSize: 25),),
            SizedBox(width: 1,),
          ],
        )

      ],
    );
  }

  Widget buildInfoBlock(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text("étage: ", style: TextStyle(fontSize: 25),),
              Text(currentRoom.floor.toString(), style: TextStyle(fontSize: 25),),

            ],
          ),
          Text(currentRoom.service.title, style: TextStyle(fontSize: 15),),
          Expanded(child: buildListPatient(context))

        ],
      ),
    );
  }


  Widget buildListPatient(BuildContext context) {
    if (currentRoom.patients != null) {
      if (currentRoom.patients.isNotEmpty) {

        return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            child: MyListBuilder(
              list: currentRoom.patients,
              builder: (context, index) {
                return MyAnimationListBuilder(
                    index: index,
                    child: buildPatientBlock(context, currentRoom.patients[index])
                );
              },
            )
        );
      } else {
        return Container(
          child: Text('Pas de patients dans cette salle'),
        );
      }
    } else {
      return MyLoading();
    }
  }

  Widget buildPatientBlock(BuildContext context, Patient patient) {
    return ListTile(
      title: Text(patient.firstname + ' ' + patient.lastname),
      subtitle: Text('${patient.birthdate.day.toString()} ${patient.birthdate.month.toString()} ${patient.birthdate.year.toString()}'),
      trailing: Text(patient.ssNumber),
    );
  }

  Widget buildCurrentPatientToThisRoom(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: HelpitalColors.red,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: InkWell(
        onTap: () async {
          if (!isClick) {
            isClick = true;
            bool isValid = await PatientService().updatePatient(currentPatient, Room(id: 0));

            if (isValid) {
              await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => StateDialog(
                    title:'Succée' ,
                    content: 'Le patient a été Libéré avec succée',
                    color: HelpitalColors.green,
                  )
              );
              Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
            } else {
              await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => StateDialog(
                    title:'Erreur' ,
                    content: 'Il semblerai qu\'il y ai un problème',
                    color: HelpitalColors.red,
                  )
              );
            }
            isClick = false;
          }
        },
        child: Center(
          child: Container(

            child: Text('Libéré le patient', style: TextStyle(color: HelpitalColors.white, fontSize: 25),),
          ),
        ),
      ),
    );
  }
}
