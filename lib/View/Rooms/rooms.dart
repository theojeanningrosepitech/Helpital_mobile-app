import 'package:flutter/material.dart';

import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Rooms/listOfBlockRooms.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';

import '../../Models/Rooms/Room.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key key}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List<Room> listRoom;
  List<Room> listRoomFree = [];
  List<Room> listRoomMedium = [];
  List<Room> listRoomFull = [];
  String searchValue;

  void setSortList() {
    listRoomFree = [];
    listRoomMedium = [];
    listRoomFull = [];
    listRoom.forEach((element) {
      if (element.type.id == 2) {
        double value = ((element.patients.length ?? 0) * 100 / element.capacity).isNaN ? 0.0 : ((element.patients.length ?? 0) * 100 / element.capacity);
        if (value < 35) {
          listRoomFree.add(element);
        }
        else if (value >= 35 && value <= 80) {
          listRoomMedium.add(element);
        }
        else if (value > 80) {
          listRoomFull.add(element);
        }
      }
    });
  }
  void setSearchingList(String value) {
    List<Room> bufferListRoom = [];
    if (value != null) {
      listRoom.forEach((element) {
        if (element.title.contains(value)) {
          bufferListRoom.add(element);
        }
      });
      listRoom = bufferListRoom;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        body:  Column(
            children: [
              MySearchingBar(
                  currentInput: (value) {
                    if (listRoom != null) {
                      setState(() {
                        searchValue = value;
                      });
                    }
                  },
                ),
              Expanded(
                flex: 7,
                child: buildCore(context),
              )
            ]
        )
    );
  }

  Widget buildCore(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: FutureBuilder(
          future: RoomsService().getRoomsListWithPatient(),
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              listRoom = snapshot.data;
              setSearchingList(searchValue);
              setSortList();
              return Column(
                children: [
                  buildTitle(HelpitalStrings.FREE_ROOM),
                  ListBlocksRooms(listRoom: listRoomFree,),
                  buildTitle(HelpitalStrings.MID_FULL_ROOM),
                  ListBlocksRooms(listRoom: listRoomMedium,),
                  buildTitle(HelpitalStrings.FULL_ROOM),
                  ListBlocksRooms(listRoom: listRoomFull,)
                ],
              );
            }
          },
        )
    );
  }

  Widget buildTitle(String title) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
      Container(
      width: double.infinity,
      height: 1,
      color: HelpitalColors.myColorTextGreyClair,
    ),

      Container(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width *0.5,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),

                  ),

              color: HelpitalColors.myColorTextGreyClair
            ),
            child: Text(
                title,
              style: TextStyle(
                color: HelpitalColors.myColorTextIcon
              ),
            ),
          ),

      ),
    ]
    );
  }
}
