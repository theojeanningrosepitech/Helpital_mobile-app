import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/ScanQrCode/scanQrCode.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/PatternPages/pageSettingsDefault.dart';

import '../../Models/Patients/Patient.dart';

class ScanPatientPage extends StatefulWidget {
  const ScanPatientPage({Key key}) : super(key: key);

  @override
  _ScanPatientPageState createState() => _ScanPatientPageState();
}

class _ScanPatientPageState extends State<ScanPatientPage> {

  bool qrCodeIsGood = false;
  Patient patient;

  @override
  Widget build(BuildContext context) {
    return PageSettingsDefault(
      name: 'Scanner un patient',
      child: Center(
        child: Column(
          children: [
            buildQrCode(context),
            qrCodeIsGood ? buildPatientCard(context) : buildNotSelectedPatientMessage(context)
          ],
        ),
      )
    );
  }
  Widget buildQrCode(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: SizeCustom().assignHeight(context: context, fraction: 0.4),
      width: SizeCustom().assignWidth(context: context, fraction: 0.9),
      decoration: BoxDecoration(
        color: HelpitalColors.myColorThird,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ScanQrCode(
          getCode: (str) {
            print(str);
          },
        ),
      )
    );
  }
  Widget buildNotSelectedPatientMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text('Sélectioné un patient'),
    );
  }
  Widget buildPatientCard(BuildContext context) {
    return Container(
      height: SizeCustom().assignHeight(context: context, fraction: 0.4),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

              Container(
                alignment: Alignment.centerLeft,
                height: SizeCustom().assignHeight(context: context, fraction: 0.1),
                child: Text(
                  '${patient.firstname} ${patient.lastname}',
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
              ),

         Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(30)),

             color: HelpitalColors.myColorTextGreyClair,

           ),
         height: SizeCustom().assignHeight(context: context, fraction: 0.1),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('n° de sécurité sociale'),
                        Text(patient.ssNumber.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date de naissance'),
                        Text(patient.birthdate.toString()),
                      ],
                    ),
                  ],
                ),
              ),

          MyButtonCustom(
              name: 'voir la fiche',
              onClick: () {

              }
          )
        ],
      ),
    );
  }
}
