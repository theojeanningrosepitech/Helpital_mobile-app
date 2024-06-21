import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/FreeRoomWidget/blockRoomWidget.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../../../Models/Rooms/Room.dart';
import '../../../../Services/waitingRoomsService.dart';
import '../../../../Utils/values.dart';

class WidgetFreeWaitingRoom extends StatefulWidget {
  const WidgetFreeWaitingRoom({Key key}) : super(key: key);

  @override
  _WidgetFreeWaitingRoomState createState() => _WidgetFreeWaitingRoomState();
}

class _WidgetFreeWaitingRoomState extends State<WidgetFreeWaitingRoom> {
  List<Room> listRoom;
  _WidgetFreeWaitingRoomState() {
    WaitingRoomsService().getWaitingRoomsServiceListWithPatient().then((value) {
      setState(() {
        listRoom = value;
      });
    });
  }

  void setFreeRoom() {
    List<Room> bufferListRoom = [];
    listRoom.forEach((element) {

      if (element.patients.length == 0) {
        bufferListRoom.add(element);
      }
    });
    listRoom = bufferListRoom;
  }
  @override
  Widget build(BuildContext context) {
    if (listRoom != null) {
      setFreeRoom();
    return Container(
        height: SizeCustom().assignHeight(context: context, fraction: 0.3),
        width: SizeCustom().assignWidth(context: context, fraction: 1),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: HelpitalColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],

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
            buildTitle(context),

            buildBottom(context)
          ],
        ),

    );
    } else {
      return MyLoading();
    }
  }

  Widget buildTitle(BuildContext context) {

    return Container(
        alignment: Alignment.centerLeft,
        child:  Container(
          height: SizeCustom().assignHeight(context: context, fraction: 0.05),
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
          ),
          decoration: BoxDecoration(
              color: HelpitalColors.myColorThird,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              )
          ),
          child: Text(
            'Salle d\'attente',
            style: TextStyle(
                fontSize: 16,
                color: HelpitalColors.white
            ),
          ),
        )
    );
  }

  Widget buildBottom(BuildContext context) {
    return Container(
      height: SizeCustom().assignHeight(context: context, fraction: 0.25),
      child: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: viewportConstraints.maxWidth
                  ),
                  child: AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listRoom.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: new Material(
                                    color: Colors.transparent,
                                    child: BlockFreeRoomWidget(room: listRoom[index])
                                ),
                              ),
                            ),
                          );
                        },
                      )),

                ));
          })),
    );
  }
}
