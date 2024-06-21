import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/waitingRoomsService.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myCustomScrollView.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myListBuilder.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Rooms/Room.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import 'BlocksWaitingRooms/blockInfoWaitingRooms.dart';
import 'InfoElementOfWaitingRoom.dart';

class WaitingRooms extends StatefulWidget {
  const WaitingRooms({Key key}) : super(key: key);

  @override
  _WaitingRoomsState createState() => _WaitingRoomsState();
}

class _WaitingRoomsState extends State<WaitingRooms> {

  List<Room> listWR;
  String searchValue;

  void setSearchingList(String value) {
    List<Room> bufferListwaitingRoom = [];

    if (value != null) {
      listWR.forEach((element) {
        if (element.title.contains(value)) {
          bufferListwaitingRoom.add(element);
        }
      });
      listWR = bufferListwaitingRoom;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        body: MyCustomScrollView(
          child: Column(
            children: [
              MySearchingBar(
                currentInput: (value) {
                  print("the value is: " + value);
                  if (listWR != null) {
                    setState(() {
                      searchValue = value;
                    });
                  }
                },
              ),
              buildListOfWaitingRooms(context),
            ],
          ),
        ));

  }

  Widget buildListOfWaitingRooms(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: FutureBuilder<List<Room>>(
          future: WaitingRoomsService().getWaitingRoomsServiceList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              listWR = snapshot.data;
              print(listWR);
              setSearchingList(searchValue);
              return MyListBuilder(
                list: listWR,
                builder: (context, index) {
                  return MyAnimationListBuilder(
                    index: index,
                    child: buildBlockInfoWaitingRooms(
                        context, listWR[index]
                    ),
                  );
                },
              );
            }
          },
        ));
  }

  Widget buildBlockInfoWaitingRooms(BuildContext context, Room waitingRoom) {
      return BlockInfoWaitingRooms(
        name: waitingRoom.title,
        step: waitingRoom.floor.toString(),
        quantity: waitingRoom.patients.length.toString(),
        maxQuantity: waitingRoom.capacity.toString(),
        onClickElem: () {
          print('Create Room');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InfoElementOfWaitingRoom(waitingRoom: waitingRoom)));
        },
        onClickButton: () {
          print("modifié");
        },
      );
  }
}
