import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Patients/Prescription.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:provider/provider.dart';

import '../../../Models/Patients/Patient.dart';
import '../../../Services/patientService.dart';
import '../../../Services/stateManagerPatient.dart';
import '../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../Widgets/UtilsWidgets/myLoading.dart';
import '../../Note/stateDialog.dart';
import 'PatientPrescriptionPages/patientPrescriptionDetailsPage.dart';

class PatientMainPage extends StatefulWidget {
  const PatientMainPage({Key key}) : super(key: key);

  @override
  State<PatientMainPage> createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientMainPage> {
  DateTime day;

  _PatientMainPageState() {
    if (day == null) day = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [buildTopPage(context), buildCore(context)],
      ),
    );
  }

  Widget buildTopPage(BuildContext context) {
    final Patient patient = context.watch<StateManagerPatient>().patient;
    return Container(
        height: SizeCustom().assignHeight(context: context, fraction: 0.2),
        color: HelpitalColors.myColorPrimary,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(
              width: SizeCustom().assignWidth(context: context, fraction: 0.7),
              child: Wrap(
                children: [
                  Text(
                    'Bonjour ${patient.firstname},',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30, color: HelpitalColors.white),
                  ),
                  Text(
                    'voici les dernières informations vous concerant',
                    style: TextStyle(
                        fontSize: 20,
                        color: HelpitalColors.myColorTextGreyClair),
                  ),
                ],
              ),
            ),
            Image.asset(
              HelpitalAssets.HELPITAL_WHITE,
              height: SizeCustom().assignWidth(context: context, fraction: 0.17),
              width: SizeCustom().assignWidth(context: context, fraction: 0.17),
            ),
          ],
        ));
  }

  Widget buildCore(BuildContext context) {
    final Patient patient = context.watch<StateManagerPatient>().patient;

    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: SizeCustom().assignHeight(context: context, fraction: 0.65),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: SizeCustom().assignHeight(context: context, fraction: 0.25),
                    width: SizeCustom().assignWidth(context: context, fraction: 0.5),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: HelpitalColors.myColorTextGreyClair,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 1,),
                        Text(
                          'Poid   ${patient.weight.toString()}',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          'Taille   ${patient.height.toString()}',
                          style: TextStyle(fontSize: 23),
                        ),
                        SizedBox(height: 1,),
                      ],
                    ),
                  ),

                  Container(
                    height: SizeCustom().assignHeight(context: context, fraction: 0.25),
                    width: SizeCustom().assignWidth(context: context, fraction: 0.3),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: HelpitalColors.myColorTextGreyClair,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 1,),
                          Text(
                            'IMC',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            '${patient.imc.toString()}',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(height: 1,),
                        ],
                      ),

                    ),
                  )
                ],
              ),
            ),
            buildImcScale(),
            SizedBox(height: 30,),
            Container(
              child: FutureBuilder(
                future: PatientService().getPrescriptionPatient(patient.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return MyLoading();
                  }
                  if (snapshot.hasError) {
                    return MyErrorWidget();
                  } else {
                    List<Prescription> listPrescription = snapshot.data;
                    if (listPrescription.length > 0) {

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientPrescriptionDetailsPage(prescription: listPrescription[0])));
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: HelpitalColors.myColorTextGrey,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)
                              )
                          ),
                          height: SizeCustom().assignHeight(context: context, fraction: 0.06),
                          width: SizeCustom().assignWidth(context: context, fraction: 1),
                          child: Center(
                            child:  Text('Prescription de Mr ${listPrescription[0].creatorLogin}',
                              style: TextStyle(color: HelpitalColors.white, fontSize: 20),
                            ),
                          )
                      ),
                    );
                    } else {
                      return Container();
                    }

                  }
                },
              ),
            )
          ],
        ));
  }

  Widget buildImcScale() {
    final Patient patient = context.watch<StateManagerPatient>().patient;

    List<int> scaleImc = [
      15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35
    ];
    Color colorImc = HelpitalColors.white;
    if (patient.imc >= 24 && patient.imc < 30) {
      colorImc = HelpitalColors.orange;
    } else if (patient.imc <= 19) {
      colorImc = Colors.blueAccent;
    } else if (patient.imc >= 30) {
      colorImc = HelpitalColors.red;
    } else {
      colorImc = HelpitalColors.green;
    }
    List<Widget> listWidget = [];
    scaleImc.forEach((element) {
      if (element == 19) {
        listWidget.add(
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  )
              ),
              height: SizeCustom().assignHeight(context: context, fraction: 0.05),
              width: SizeCustom().assignHeight(context: context, fraction: 0.05),
              child: Center(
                child: Text(element.toString(), style: TextStyle(
                    fontSize: 17
                ),),
              ),
            ));
      }
      else if (element == 24) {
        listWidget.add(
            Container(
              decoration: BoxDecoration(
                  color: HelpitalColors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  )
              ),
              height: SizeCustom().assignHeight(context: context, fraction: 0.05),
              width: SizeCustom().assignHeight(context: context, fraction: 0.05),
              child: Center(
                child: Text(element.toString(), style: TextStyle(
                    fontSize: 17
                ),),
              ),
            ));
      }
      else if (element == 30) {
        listWidget.add(
            Container(
              decoration: BoxDecoration(
                  color: HelpitalColors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  )
              ),
              height: SizeCustom().assignHeight(context: context, fraction: 0.05),
              width: SizeCustom().assignHeight(context: context, fraction: 0.05),
              child: Center(
                child: Text(element.toString(), style: TextStyle(
                    fontSize: 17
                ),),
              ),
            ));
      }
      else if (element == patient.imc) {
        listWidget.add(
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorImc,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  )
              ),
              height: SizeCustom().assignHeight(context: context, fraction: 0.06),
              width: SizeCustom().assignHeight(context: context, fraction: 0.06),
              child: Center(
                child: Text(element.toString(), style: TextStyle(
                    fontSize: 17
                ),),
              ),
            )
        );


      }
      else {
        listWidget.add(
            SizedBox(height: 1,width: 1,)
        );
      }
    });
    return InkWell(
        onTap: () {
          showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Comment comprendre son IMC ?', style: TextStyle(fontSize: 30, color: HelpitalColors.myColorTextGrey), textAlign: TextAlign.center,),
            content: Center(
              child: Column(
                children: [
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Moins de 18.5', style: TextStyle(fontSize: 25, color: Colors.blueAccent),),
                          SizedBox(height: 5,),
                          Text('Poids insuffisant et pouvant occasionner certains risques pour la santé.', style: TextStyle(fontSize: 20),),
                          SizedBox(height: 30,),
                          Text('Entre 18.5 et 24.9', style: TextStyle(fontSize: 25, color: HelpitalColors.green),),
                          SizedBox(height: 5,),
                          Text('Poids santé qui n\'augmente pas les risques pour la santé.', style: TextStyle(fontSize: 20),),
                          SizedBox(height: 30,),
                          Text('Entre 25 et 29.9', style: TextStyle(fontSize: 25, color: HelpitalColors.orange),),
                          SizedBox(height: 5,),
                          Text('Excès de poids pouvant occasionner certains risques pour la santé.', style: TextStyle(fontSize: 20),),
                          SizedBox(height: 30,),
                          Text('Plus de 30', style: TextStyle(fontSize: 25, color: HelpitalColors.red),),
                          SizedBox(height: 5,),
                          Text('Obésité, risque accru de développer certaines maladies.', style: TextStyle(fontSize: 20),),
                          SizedBox(height: 30,),
                        ],
                      ))
                ],


              ),


            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {

                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Retour', textAlign: TextAlign.start, style: TextStyle(color: HelpitalColors.myColorSecondary),),
              ),
            ],
          ));
        },
        child: Container(
            height: SizeCustom().assignHeight(context: context, fraction: 0.08),
            width: SizeCustom().assignWidth(context: context, fraction: 1),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Colors.blueAccent,
                            HelpitalColors.green,
                            HelpitalColors.orange,
                            HelpitalColors.red,

                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)
                        )
                    ),
                    height: SizeCustom().assignHeight(context: context, fraction: 0.03),
                    width: SizeCustom().assignWidth(context: context, fraction: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: listWidget,
                  )
                ],
              ),
            )
        )
    );



  }
}
