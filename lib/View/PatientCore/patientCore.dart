import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/PatientFilesPages/PatientFilesPage.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/PatientNotePages/PatientNotePage.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/PatientPrescriptionPages/patientPrescriptionPage.dart';
import 'package:helpital_mobile_app/View/PatientCore/Pages/patientMainPage.dart';
import 'package:helpital_mobile_app/View/PatientCore/patientProfil.dart';
import 'package:provider/provider.dart';

import '../../Models/Patients/Patient.dart';
import '../../Services/stateManagerPatient.dart';
import '../../Utils/icons.dart';
import '../../Utils/values.dart';
import '../../Widgets/UtilsWidgets/myRouteBuilder.dart';

class PatientCore extends StatefulWidget {
  const PatientCore({Key key}) : super(key: key);

  @override
  _PatientCoreState createState() => _PatientCoreState();
}

class _PatientCoreState extends State<PatientCore> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: HelpitalColors.myColorTextGrey
  );
  static const List<Widget> _widgetOptions = <Widget>[
    PatientMainPage(),
    PatientPrescriptionPage(),
    PatientNotePage(),
    PatientFilesPage()

  ];
  static const List<BottomNavigationBarItem> _widgetButton = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note_add_sharp),
      label: 'Prescription',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Note',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.file_copy_rounded),
      label: 'Fichier',
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: HelpitalColors.myColorBackground,
      appBar: buildAppBar(context),
      body: buildBodyCore(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add_sharp),
            label: 'Prescription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_rounded),
            label: 'Fichier',
          )
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: HelpitalColors.myColorTextIcon,
        selectedItemColor: HelpitalColors.myColorPrimary,
        unselectedLabelStyle: optionStyle,
        onTap: _onItemTapped,
      ),
    );
}
  Widget buildBodyCore(BuildContext context) {
    final Patient patient = context.watch<StateManagerPatient>().patient;

    return Container(
      child: Center(
        child: Column(
          children: [
            _widgetOptions[_selectedIndex],

          ],
        ),
      ),
    );
  }

    Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: HelpitalColors.white,
    elevation: 0.0,
    leading: IconButton(
      icon: myProfileIcon,
      onPressed: () {
        Navigator.of(context)
            .push(MyRouteBuilder().createRoute(PatientProfil(), -1.0, 0.0));
      },
    ),
    title: Image.asset(
      HelpitalAssets.HELPITAL,
      scale: 10,
    ),
    shape: ContinuousRectangleBorder(
      side:
      BorderSide(style: BorderStyle.solid, color: HelpitalColors.white.withOpacity(0.7)),
      /*borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90.0),
          bottomRight: Radius.circular(90.0),
        ),*/
    ),
    actions: <Widget>[


    ],
  );


}
}
