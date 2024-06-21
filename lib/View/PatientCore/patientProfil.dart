import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Models/Patients/Patient.dart';
import '../../Models/Rooms/Room.dart';
import '../../Models/Utils/ConnectionParameters.dart';
import '../../Services/stateManager.dart';
import '../../Services/stateManagerConnection.dart';
import '../../Services/stateManagerPatient.dart';
import '../../Services/stateManagerTypeOfUser.dart';
import '../../Utils/values.dart';
import '../../Widgets/Buttons/myButtonCustom.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../Widgets/UtilsWidgets/myLoading.dart';
import '../../Widgets/myTextFieldCustom.dart';

class PatientProfil extends StatefulWidget {
  const PatientProfil({Key key}) : super(key: key);

  @override
  State<PatientProfil> createState() => _PatientProfilState();
}

class _PatientProfilState extends State<PatientProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildCore(context),
    );
  }

  Widget buildCore(BuildContext context) {
    final Patient patient = (context.watch<StateManagerPatient>()).patient;

    String name = patient.firstname + ' ' + patient.lastname;
    String birthdate = patient.birthdate.day.toString() +
        '/' +
        patient.birthdate.month.toString() +
        '/' +
        patient.birthdate.year.toString();
    String id = patient.id.toString();
    int roomId = patient.roomId;
    String ssNumber = patient.ssNumber;
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            height: SizeCustom().assignHeight(context: context, fraction: 0.07),

            child: Text(
              name,
              style: TextStyle(
                fontSize: 30
              ),
            ),
          ),
          Container(
              height:
              SizeCustom().assignHeight(context: context, fraction: 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  MyTextFieldCustom(
                    canEdit: false,
                    name: id,
                    icon: Icons.perm_identity,
                    textObscure: false,
                    currentInput: (input) {
                      print(input);
                    },
                  ),
                  MyTextFieldCustom(
                    canEdit: false,
                    name: birthdate,
                    icon: Icons.calendar_month,
                    textObscure: false,
                    currentInput: (input) {
                      print(input);
                    },
                  ),
                  MyTextFieldCustom(
                    canEdit: false,
                    name: ssNumber,
                    icon: Icons.health_and_safety,
                    textObscure: false,
                    currentInput: (input) {
                      print(input);
                    },
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              height:
                  SizeCustom().assignHeight(context: context, fraction: 0.25),
              width: SizeCustom().assignWidth(context: context, fraction: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: SizeCustom().assignWidth(context: context, fraction: 0.35),
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
                      children: [
                        Container(

                          child: Text(
                            'Chambre',
                            style: TextStyle(color: HelpitalColors.white, fontSize: 15),
                          ),
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(right: 30),
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5
                          ),
                          decoration: BoxDecoration(
                              color: HelpitalColors.myColorFourth,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                              )
                          ),
                          //padding: EdgeInsets.all(),
                        ),
                        
                        FutureBuilder<Room>(
                          future: RoomsService().getRoom(roomId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            if (snapshot.hasError) {
                              return MyErrorWidget();
                            } else {
                              Room room = snapshot.data;
                              return Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('Noms: ' + room.title ,style: TextStyle(fontSize: 15),),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(height: 10,),
                            Container(
                            child: Text('Étage: ' + room.floor.toString() ,style: TextStyle(fontSize: 15)),
                              alignment: Alignment.centerLeft,
                            ),
                                    SizedBox(height: 10,),
                            Container(
                            child: Text('Service: ' + room.service.title ,style: TextStyle(fontSize: 10)),
                              alignment: Alignment.centerLeft,
                            )
                                  ],

                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ),
                  Container(
                    child: QrImage(
                      data: id,
                      version: QrVersions.auto,
                      size: 170.0,
                    ),
                  )
                ],
              )),
          Container(
              height:
                  SizeCustom().assignHeight(context: context, fraction: 0.07),
              child: MyButtonCustom(
                name: HelpitalStrings.DISCONNECT,
                onClick: () {
                  setState(() async {
                    context.read<StateManagerConnection>().unvalideConnection();
                    context
                        .read<StateManagerTypeOfUser>()
                        .setUser(TypeOfUser.NoSelected);
                    context.read<StateManager>().disconnect();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                  });
                },
              ))
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) => AppBar(
        elevation: 0.0,
        backgroundColor: HelpitalColors.white,
        /*leading: IconButton(
      icon: Icon(
        Icons.settings,
        color: HelpitalColors.myColorTextIcon,
      ),
      onPressed: () {
        if (user != null) {
          Navigator.of(context).push(
              MyRouteBuilder().createRoute(ProfilSettings(user: this.user,), -1.0, 0.0));
        }

      },
    ),*/
        title: Image.asset(
          HelpitalAssets.HELPITAL,
          scale: 10,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: HelpitalColors.myColorTextGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
}
