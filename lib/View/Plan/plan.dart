import 'dart:math';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import 'PlanComponents/myFancyPaint.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class RoomParameters {
  String title;
  int type;
  int sizeX;
}
class Floor {
  String floor;
  int i;
  Floor({
   this.floor,
   this.i
});
}
void displayListOfObject(String arg, List<Room> obj) {
  obj.forEach((element) => print(arg + ' = ' + element.positionY.toString()));
}

class _PlanState extends State<Plan> {
  String service;
  List<String> serviceList = [
    'Admin',
    'Radiologie',
    'Cardiologie',
    'Pédiatrie',
    'Pneumologie',
    'Neurologie',
    'Cancerologie',
    'Néphrologie',
    'Psychologie',
    'Soin Palliatifs',
    'Reception'

  ];
  List floorList = [
    Floor(floor: 'étage 6', i: 6),
    Floor(floor: 'étage 5', i: 5),
    Floor(floor: 'étage 4', i: 4),
    Floor(floor: 'étage 3', i: 3),
    Floor(floor: 'étage 2', i: 2),
    Floor(floor: 'étage 1', i: 1),
    Floor(floor: 'Rdc', i: 0),
    Floor(floor: 'étage -1', i: -1),
    Floor(floor: 'étage -2', i: -2),
  ];
  List floorStringList = [
    'étage 6',
    'étage 5',
    'étage 4',
    'étage 3',
    'étage 2',
    'étage 1',
    'Rdc',
    'étage -1',
    'étage -2',
  ];
  List<Room> listRoom;
  Floor currentFloor = Floor(floor: 'Rdc', i: 0);
  _PlanState() {
    RoomsService()
        .getAllRoomsList()
        .then((List<Room> value) => setState(() => this.listRoom = value));
  }

  void changeFloor(floor) {
    setState(() {
      this.currentFloor = floor;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (listRoom != null) {
      return Scaffold(
          backgroundColor: HelpitalColors.myColorBackground,
          body: buildCore()
      );
    }
    else {
      return Center(
        child: MyLoading(),
      );
    }
  }

  Widget buildCore() {
    return Container(
      child: Stack(
        children: [
          InteractiveViewer(
            maxScale: 1000,
            minScale: 0.1,
            //boundaryMargin: const EdgeInsets.all(double.infinity),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CustomPaint(
                  painter: MyFancyPainter(
                      listRoom: listRoom,
                      floor: this.currentFloor.i,
                      serviceId: serviceList.indexOf(service) + 1

                  ),
                ),
              )
            ),
          ),
          buildMenuFloor(context)
        ],
      ),

    );
  }

  Widget buildMenuFloor(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
        margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: HelpitalColors.white,

      ),
      height: size.height * 0.1,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDropDownServices(),
          buildDropDownFloor()
        ],
      )
    );
  }
/*  Widget buildButtonFloor(String name, index) {
    var color = HelpitalColors.white;
    if (this.currentFloor == index) {
      color = HelpitalColors.myColorSecondary;
    }
    return  InkWell(
      onTap: () {
        changeFloor(index);

      },
      child: Container(
          width: double.infinity,

          color: color,
          child: Center(
            child: Text(name),
        ),
      )
    );
  }*/
 /* Widget buildLineMenu() {
    return Container(height: 3, color: HelpitalColors.myColorTextGreyClair,);
  }*/


  Widget buildDropDownFloor() {

    return DropdownButton(
      value: currentFloor.floor,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          currentFloor = Floor(floor: value, i: floorList[floorStringList.indexOf(value)].i);
        });
      },
      items: floorStringList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget buildDropDownServices() {
    if (service == null)
      service = serviceList.first;
    return DropdownButton<String>(
      value: service,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          service = value;
        });
      },
      items: serviceList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}