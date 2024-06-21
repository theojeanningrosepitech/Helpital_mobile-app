import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/patientService.dart';
import 'package:helpital_mobile_app/Services/stateManagerConnection.dart';
import 'package:helpital_mobile_app/Services/stateManagerPatient.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';
import 'package:provider/provider.dart';

import '../../Models/Patients/Patient.dart';
import '../../Models/Utils/ConnectionParameters.dart';
import '../../Services/stateManager.dart';
import '../../Services/stateManagerPatient.dart';
import '../ScanQrCode/scanQrCode.dart';

class PatientConnect extends StatefulWidget {
  @override
  _PatientConnectState createState() => _PatientConnectState();
}

class _PatientConnectState extends State<PatientConnect> {
  int id;
  Patient patient;
  bool isConnected = false;


  void connection(BuildContext context) async {

    if (id != null) {
      bool isConnect = await PatientService().getPatient(id, context);
        if (isConnect) {
          context.read<StateManager>().connect();
          bool state = context.watch<StateManager>().state;
          Navigator.pop(context);
        } else {
          context.read<StateManager>().disconnect();
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      body: Center(
        heightFactor: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: size.height,
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: HelpitalColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    buildLogo(),
                    Text(
                      'Scannée votre QrCode',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    MyTextFieldCustom(
                        name: 'entrée id',
                        currentInput: (_id) {
                          setState(() {
                            id = int.parse(_id);
                          });
                        },
                        icon: Icons.person),

                    SizedBox(height: 16),
                    buildQrCodeReader(context)
                  ],
                ),
              ),
              SizedBox(height: 15),
              buildPatientConnectButton(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildQrCodeReader(BuildContext context) {
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
              setState(() {
                id = int.parse(str);
                connection(context);
              });
            },
          ),
        )
    );
  }
  Widget buildLogo() {
    return Image.asset(
      HelpitalAssets.HELPITAL,
      scale: 5,
    );
  }

  Widget buildPatientConnectButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: MyButtonCustom(
          name: HelpitalStrings.CONNEXION,
          onClick: () async => connection(context)),
    );
  }
}
