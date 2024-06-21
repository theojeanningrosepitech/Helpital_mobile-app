import 'package:flutter/material.dart';

import '../../../../../Models/Patients/Patient.dart';
import '../../../../../Models/Rooms/Room.dart';
import '../../../../../Services/waitingRoomsService.dart';
import '../../../../../Utils/values.dart';
import '../../../../../Widgets/PatternPages/pageScrollableDefault.dart';
import '../../../../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../../../Widgets/UtilsWidgets/myLoading.dart';
import '../../../../../Widgets/mySearchingBar.dart';
import '../infoTransfertRoom.dart';

class TransfertWaitingRoom extends StatefulWidget {
  Patient patient;
  TransfertWaitingRoom({Key key, this.patient}) : super(key: key);

  @override
  _TransfertWaitingRoomState createState() => _TransfertWaitingRoomState();
}

class _TransfertWaitingRoomState extends State<TransfertWaitingRoom> {



  List<Room> listWR;
  String searchValue;
  Widget setChild;
  bool childIsSet = false;
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
    if (!childIsSet) {
      setChild = buildListOfWaitingRooms(context);
      childIsSet = true;
    }
    return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        appBar: AppBar(
      backgroundColor: HelpitalColors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Image.asset(
        HelpitalAssets.HELPITAL,
        scale: 10,
      ),
    ),
        body: buildCore(context)
    );

  }
  Widget buildCore(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: MySearchingBar(
                  currentInput: (value) {
                    if (listWR != null) {
                      setState(() {
                        searchValue = value;
                      });
                    }
                  }
              ),
            ),
          ],
        ),

        Container(
          height: SizeCustom().assignHeight(context: context, fraction: 0.786),
          child:buildListOfWaitingRooms(context),

        ),
      ],

    );
  }
  Widget buildListOfWaitingRooms(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: FutureBuilder<List<Room>>(
          future: WaitingRoomsService().getWaitingRoomsServiceListWithPatient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              listWR = snapshot.data;
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

  Widget buildBlockInfoWaitingRooms(BuildContext context, Room room) {
    Color secondPartColor = HelpitalColors.white;
    if (room.patients.length > (room.capacity / 2)) {
      secondPartColor = HelpitalColors.myColorPrimary;
    } else {
      secondPartColor = HelpitalColors.green;

    }
    return  Container(
      height: SizeCustom().assignHeight(context: context, fraction: 0.1),
      margin: EdgeInsets.only(
          left: 20,
          top: 5
      ),
      child: InkWell(
          highlightColor: HelpitalColors.white,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoTransfertRoom(room: room, patient: widget.patient,)));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
            ),
            child: Row(
              children: [
                Container(
                  width: SizeCustom().assignWidth(context: context, fraction: 0.3),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                  ),
                  child: Column(
                    children: [
                      Text(
                        room.title,
                        style: TextStyle(
                            color: HelpitalColors.white,
                            fontSize: SizeCustom().assignTextSize(
                                context: context,
                                sizeText: room.title.length,
                                size: 25
                            )
                        ),
                      ),
                      Text(
                        'étage: ${room.floor.toString()}',
                        style: TextStyle(
                            color: HelpitalColors.white,
                            fontSize: SizeCustom().assignTextSize(
                                context: context,
                                sizeText: ('étage: ${room.floor.toString()}').length,
                                size: 25
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  color: HelpitalColors.white,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: double.infinity,
                  width: SizeCustom().assignWidth(context: context, fraction: 0.6),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        secondPartColor,
                        secondPartColor.withOpacity(0.5),
                        HelpitalColors.white
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        room.patients.length.toString(),
                        style: TextStyle(
                            color: HelpitalColors.white,
                            fontSize: SizeCustom().assignTextSize(
                                context: context,
                                sizeText: room.patients.length.toString().length,
                                size: 20
                            )
                        ),
                      ),
                      SizedBox(width: SizeCustom().assignWidth(context: context, fraction: 0.1),),
                      Text(
                        '/',
                        style: TextStyle(
                            color: HelpitalColors.white,
                            fontSize: SizeCustom().assignTextSize(
                                context: context,
                                sizeText: '/'.length,
                                size: 30
                            )
                        ),
                      ),
                      SizedBox(width: SizeCustom().assignWidth(context: context, fraction: 0.1),),
                      Text(
                        room.capacity.toString(),
                        style: TextStyle(
                            color: HelpitalColors.white,
                            fontSize: SizeCustom().assignTextSize(
                                context: context,
                                sizeText: room.capacity.toString().length,
                                size: 20
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
    /*BlockInfoRooms(
      name: Room.title,
      step: Room.floor.toString(),
      quantity: Room.patients.length.toString(),
      maxQuantity: Room.capacity.toString(),
      onClickElem: () {
        print('Create Room');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoTransfertRoom(room: Room, patient: widget.patient,)));
      },
      onClickButton: () {
        print("modifié");
      },
    );*/
  }
}

