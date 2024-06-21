import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/Patient/PatientProfil/TranfertPatientPage/TransfertFree/transfertFree.dart';
import 'package:helpital_mobile_app/View/Patient/PatientProfil/TranfertPatientPage/TransfertWaitingRoom/transferWaitingRoom.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';

import '../../../../Models/Patients/Patient.dart';
import '../../../../Models/Rooms/Room.dart';
import '../../../../Utils/values.dart';
import 'TransfertRoom/transferRoom.dart';

class TransfertPatientPage extends StatefulWidget {
  Patient patient;
  Room room;
  TransfertPatientPage({Key key, this.patient, this.room}) : super(key: key);

  @override
  _TransfertPatientPageState createState() => _TransfertPatientPageState();
}

class _TransfertPatientPageState extends State<TransfertPatientPage> {
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
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(60),
                  child: MyButtonCustom(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => TransfertWaitingRoom(patient: widget.patient,),
                        ),
                      );

                    },
                    name: 'Salle d\'attente',
                  ),
                )
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(60),
                  child: MyButtonCustom(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => TransfertRoom(patient: widget.patient,),
                        ),
                      );
                    },
                    name: 'Chambre',
                  ),
                )
            ),
            widget.room != null ? Expanded(
                child: Container(
                  padding: EdgeInsets.all(60),
                  child: MyButtonCustom(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => TransfertFree(patient: widget.patient, room: widget.room,),
                        ),
                      );
                    },
                    name: 'Libérer',
                  ),
                )
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
