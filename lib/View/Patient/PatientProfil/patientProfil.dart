import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/Patient/PatientProfil/TranfertPatientPage/transfertPatientPage.dart';
import 'package:helpital_mobile_app/View/Patient/PatientProfil/notePage.dart';

import '../../../Models/Patients/Patient.dart';
import '../../../Models/Rooms/Room.dart';
import '../../../Services/roomsService.dart';
import '../../../Utils/values.dart';
import '../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../Widgets/UtilsWidgets/myLoading.dart';
import '../../../Widgets/UtilsWidgets/myRouteBuilder.dart';
import '../../Profil/qrCodeGen.dart';

class PatientProfil extends StatefulWidget {
  Patient patient;
  PatientProfil({Key key, this.patient}) : super(key: key);

  @override
  _PatientProfilState createState() => _PatientProfilState(patient: patient);
}

class _PatientProfilState extends State<PatientProfil> {

  Patient patient;
  Room room;

  _PatientProfilState({
    this.patient
  });
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
        actions: [
          IconButton(
              onPressed: () {
    Navigator.of(context).push(MyRouteBuilder()
        .createRoute(QrCodeGen(data: '${patient.id}', title: '${patient.firstname} ${patient.lastname}'), 1.0, 1.0));

              },
              icon: const Icon(Icons.qr_code_rounded, color: HelpitalColors.myColorTextIcon,))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: buildTop(context),
              ),
              Expanded(
                flex: 3,
                child: buildMiddle(context),
              ),
              Expanded(
                flex: 8,
                child: buildRoomBlock(context),
              ),
            ],
          ),
        )
      ),
    );
  }
  Widget buildTop(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeCustom().assignWidth(context: context, fraction: 0.20),
                height: SizeCustom().assignWidth(context: context, fraction: 0.20),
                decoration: new BoxDecoration(
                  color: HelpitalColors.myColorTextGreyClair,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  HelpitalAssets.HELPITAL_LOGO,
                  scale: 3,
                )
            ),

            Center(
              child: Text('${patient.firstname} ${patient.lastname}', style: TextStyle(fontSize: 20),),
            )
          ],
        )
    );
  }
  Widget buildMiddle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
          height: SizeCustom().assignHeight(context: context, fraction: 0.06),
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HelpitalColors.myColorTextGreyClair,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.card_giftcard_outlined, color: HelpitalColors.myColorPrimary,),
          Center(
            child: Text('${patient.birthdate.day.toString()}/${patient.birthdate.month.toString()}/${patient.birthdate.year.toString()}'),
          ),
          SizedBox(width: 15,)


        ],
      )
          ),

          Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: HelpitalColors.myColorTextGreyClair,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.health_and_safety, color: HelpitalColors.myColorPrimary,),
                  Center(
                    child: Text(patient.ssNumber),
                  ),
                  SizedBox(width: 15,)
                ],
              )
          ),


        ],
      )
    );
  }

  Widget buildRoomBlock(BuildContext context) {
    return FutureBuilder(
      future: RoomsService().getRoomWithPatient(patient.roomId),
      initialData: 0,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError) {
          return MyErrorWidget();
        } else {
          room = snapshot.data;
          //setSearchingList(searchValue);
          //setSortList();
          if (room != null) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: buildRoomBlockInfo(context),
                ),
                Expanded(
                  flex: 4,
                  child: buildButtons(context),
                ),

              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Center(
                      child: Text('Le patient n\'est dans aucune chambre'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: buildButtons(context),
                ),

              ],
            );
          }
        }
      },
    );
  }

  Widget buildRoomBlockInfo(BuildContext context) {
    return Container(
        height: SizeCustom().assignHeight(context: context, fraction: 0.3),
        width: double.infinity,

        child:
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HelpitalColors.myColorTextGreyClair,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Icon(Icons.bed_outlined, color: HelpitalColors.myColorPrimary,),
          Container(
            width: SizeCustom().assignWidth(context: context, fraction: 0.7),
            margin: EdgeInsets.all(10),
            //alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  room.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(

                      fontSize: SizeCustom().assignTextSize(context: context, sizeText: room.title.length, size: 40),
                      color: HelpitalColors.myColorTextIcon
                  ),
                ),
                Text(
                  'Service: ${room.service.title}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizeCustom().assignTextSize(context: context, sizeText: 'Service: ${room.service.title}'.length, size: 40),
                      color: HelpitalColors.myColorTextIcon
                  ),
                ),
                Text('Étage: ${room.floor}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizeCustom().assignTextSize(context: context, sizeText: 'Étage: ${room.floor}'.length, size: 40),
                      color: HelpitalColors.myColorTextIcon
                  ),
                ),
                Text('Nb de patients: ${room.patients.length.toString()}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizeCustom().assignTextSize(context: context, sizeText: 'Nb de patients: ${room.patients.length.toString()}'.length, size: 40),
                      color: HelpitalColors.myColorTextIcon
                  ),
                ),

              ],
            ),
          )


      ],)

    )

    );
  }

  Widget buildButtons(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (_) => NotePage(patient: patient),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: Text(
                      'Note',
                      style: TextStyle(color: HelpitalColors.white, fontSize: 25),),
                  ),
                ),
              )
          ),
          SizedBox(width: 20,),
          Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (_) => TransfertPatientPage(patient: patient, room: room,),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: Text(
                      'Transféré',
                      style: TextStyle(color: HelpitalColors.white, fontSize: 25),),
                  ),
                ),
              )
          )

        ],
      ),
    );


  }
}
