import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Utils/ConnectionParameters.dart';
import 'package:helpital_mobile_app/Services/stateManagerTypeOfUser.dart';
import 'package:helpital_mobile_app/View/Login/login.dart';
import 'package:helpital_mobile_app/View/chooseUserPage.dart';
import 'package:provider/provider.dart';
import 'Services/stateManager.dart';
import 'Services/stateManagerPatient.dart';
import 'View/Authentification/connectionManager.dart';
import 'View/PatientCore/patientConnect.dart';
import 'View/PatientCore/patientCore.dart';
import 'View/core.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool start = false;
  @override
  Widget build(BuildContext context) {
    final bool isConnected = context.watch<StateManager>().state;
    TypeOfUser _typeOfUser = context.watch<StateManagerTypeOfUser>().typeOfUser;
    if (_typeOfUser == TypeOfUser.HospitalWorker) {
      if (isConnected) {
        return Core();
      } else {
        return ConnectionManager();
      }
    } else if (_typeOfUser == TypeOfUser.Patient) {
      if (isConnected) {
        return PatientCore();
      } else {
        return PatientConnect();
      }
    } else {
      return ChooseUserPage();
    }
  }
}


