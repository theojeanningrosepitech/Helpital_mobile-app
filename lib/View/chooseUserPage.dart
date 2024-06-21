import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Utils/ConnectionParameters.dart';
import 'package:helpital_mobile_app/Services/stateManagerTypeOfUser.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:provider/provider.dart';


class ChooseUserPage extends StatefulWidget {
  @override
  _ChooseUserPageState createState() => _ChooseUserPageState();
}

class _ChooseUserPageState extends State<ChooseUserPage> {

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
                      'Bonjour, Quel type d\'utilisateur êtes-vous?',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    buildChoosePatientButton(context),
                    SizedBox(height: 16),
                    buildChooseHospitalWorkerButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      HelpitalAssets.HELPITAL,
      scale: 5,
    );
  }

  Widget buildChooseHospitalWorkerButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: MyButtonCustom(
          name: 'Je travail dans l\'hopital',
          onClick: () {
            context.read<StateManagerTypeOfUser>().setUser(TypeOfUser.HospitalWorker);

          }),
    );
  }
  Widget buildChoosePatientButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: MyButtonCustom(
          name: 'Je suis patient de l\'hopital',
          onClick: () {
            context.read<StateManagerTypeOfUser>().setUser(TypeOfUser.Patient);

          }),
    );
  }
}
