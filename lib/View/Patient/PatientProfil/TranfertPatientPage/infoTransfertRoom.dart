import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/patientService.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../../../Models/Patients/Patient.dart';
import '../../../../Models/Rooms/Room.dart';
import '../../../../Utils/values.dart';
import '../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../Note/stateDialog.dart';

class InfoTransfertRoom extends StatefulWidget {
  Room room;
  Patient patient;
  InfoTransfertRoom({Key key, this.room, this.patient}) : super(key: key);

  @override
  _InfoTransfertRoomState createState() => _InfoTransfertRoomState(
    room: room,
    currentPatient: patient
  );
}

class _InfoTransfertRoomState extends State<InfoTransfertRoom> {
  Room room;
  Patient currentPatient;
  bool isClick = false;
  //List<Patient> patients;
  _InfoTransfertRoomState({this.room, this.currentPatient}) {
    PatientService().getPatientsByRoom(room.id).then((value) {
      setState(() {
        room.patients = value;
      });
    });
  }
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
          child: buildCore(context),
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
              child: buildBlockInfoObj(context)
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
  Widget buildBlockInfoObj(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HelpitalColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: HelpitalColors.black,
            offset: Offset(0.0, 1.0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(room.title, style: TextStyle(fontSize: 30),),
          SizedBox(width: 1,),
          Text(room.service.title, style: TextStyle(fontSize: 25),),
          SizedBox(width: 1,),
          Text(room.type.title, style: TextStyle(fontSize: 25),),
          SizedBox(width: 1,),

          Text("Capacité: " + room.capacity.toString(), style: TextStyle(fontSize: 30),),


        ],
      )
    );
  }

  Widget buildInfoBlock(BuildContext context) {
    return Container(
      width: double.infinity,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: HelpitalColors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: HelpitalColors.black,
              offset: Offset(0.0, 1.0),
              blurRadius: 1,
            ),
          ],
        ),
        child:Column(
          children: [
            Text("Étage: " + room.floor.toString(), style: TextStyle(fontSize: 25),),
            Text("Superviseur: " + room.supervisor.firstName, style: TextStyle(fontSize: 15),),
            Expanded(child: buildListPatient(context))

          ],
        ),
    );
  }


  Widget buildListPatient(BuildContext context) {
    if (room.patients != null) {
      if (room.patients.isNotEmpty) {

    return Container(
      padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: HelpitalColors.myColorTextGreyClair,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      child: MyListBuilder(
      list: room.patients,
      builder: (context, index) {
        return MyAnimationListBuilder(
          index: index,
          child: buildPatientBlock(context, room.patients[index])
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
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: HelpitalColors.myColorSecondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: ListTile(
        title: Text(patient.firstname + ' ' + patient.lastname, style: TextStyle(
          color: HelpitalColors.white,
          fontSize: 20
        ),),
        trailing: Text(patient.ssNumber, style: TextStyle(
            color: HelpitalColors.myColorTextGreyClair,
        )),
      ),
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
          if (room.capacity > room.patients.length) {
          if (!isClick) {
            isClick = true;
            bool isValid = await PatientService().updatePatient(currentPatient, room);

          if (isValid) {
            await showDialog<String>(
                context: context,
                builder: (BuildContext context) => StateDialog(
                  title:'Succée' ,
                  content: 'Le patient a été transféré avec succée',
                  color: HelpitalColors.green,
                )
            );
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
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
          } else {
    await showDialog<String>(
    context: context,
    builder: (BuildContext context) => StateDialog(
    title:'Erreur' ,
    content: 'Il semblerai que la capacité de la salle à été atteinte',
    color: HelpitalColors.red,
    )
    );

          }
        },
        child: Center(
          child: Container(

            child: Text('Transférer le patient', style: TextStyle(color: HelpitalColors.white, fontSize: 25),),
          ),
        ),
      ),
    );
  }
}
