import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Patients/Patient.dart';

class InfoElementOfWaitingRoom extends StatefulWidget {
  Room waitingRoom;
  InfoElementOfWaitingRoom({this.waitingRoom});

  @override
  _InfoElementOfWaitingRoomState createState() => _InfoElementOfWaitingRoomState(waitingRoom: this.waitingRoom);
}

class _InfoElementOfWaitingRoomState extends State<InfoElementOfWaitingRoom> {
  Room waitingRoom;
  List<Patient> listPatient;
  _InfoElementOfWaitingRoomState({this.waitingRoom});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.white,
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
    shadowColor: HelpitalColors.red,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
      tooltip: 'Show Snackbar',
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Center(child: Text(waitingRoom.title, style: TextStyle(color: HelpitalColors.myColorTextIcon),),),
    actions: [
      Text(waitingRoom.capacity.toString(), style: TextStyle(color: HelpitalColors.myColorTextGrey, fontSize: 35),)
    ],
    shape: ContinuousRectangleBorder(
      side: BorderSide(
          style: BorderStyle.solid,
          color: HelpitalColors.white.withOpacity(0.7)
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(90.0),
        bottomRight: Radius.circular(90.0),

      ),

    ),
  );


  Widget buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    buildBlockInfoObj(context, size.height * 0.2),
                    //buildBlockListPatients(context, size.height * 0.25),
                   // buildBlockSupervisor(context, size.height * 0.13),
                    SizedBox(height: 30,)
                  ],
                ),

              ));
        });
  }
  //getWaitingRoomsPatientList

  Widget buildBlockInfoObj(BuildContext context, size) {
    return Container(
      height: size,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildMyRow('id:', waitingRoom.id.toString()),
          buildMyRow('Capacitée:', waitingRoom.capacity.toString()),
          buildMyRow('Étage:', waitingRoom.floor.toString()),
        ],
      ),
    );
  }
 /* Widget buildBlockListPatients(BuildContext context, size) {

    return buildBlockPatern(
        size,
        'Patients',
        AnimationLimiter(
            child: ListView.builder(
              itemCount: waitingRoom.patients.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: new Material(
                          color: Colors.transparent,
                          child: buildBlockPatient(waitingRoom.patients[index], HelpitalColors.myColorFourth)),
                    ),
                  ),
                );
              },
            ))
    );

  }*/

  Widget buildBlockPatient(Patient patient, color) => Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10))),
    child: Text(patient.firstname + ' ' + patient?.lastname, style: TextStyle(color: HelpitalColors.white),),
  );

  Widget buildBlockSupervisor(BuildContext context, size) {
    String supervisorName = waitingRoom.supervisor.toString() + ' ' + waitingRoom.supervisor.toString();
    return Container(
      height: size,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HelpitalColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorThird,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    HelpitalStrings.SUPERVISOR,
                    style: TextStyle(
                      color: HelpitalColors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(supervisorName, style: TextStyle(color: HelpitalColors.black),)
          )
        ],
      ),
    );
  }


  Widget buildBlockPatern(size, String title, Widget core) {

    return Container(
      height: size,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HelpitalColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorThird,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: HelpitalColors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Expanded(
              flex: 7,
              child: core
          )
        ],
      ),
    );
  }

  Widget buildMyRow(title, content) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildMyText(title, HelpitalColors.myColorTextGrey),
      buildMyText(content, HelpitalColors.myColorTextIcon),
    ],
  );

  Widget buildMyText(name, _color) => Text(
    name,
    style: TextStyle(fontSize: 15, color: _color),
  );
}
