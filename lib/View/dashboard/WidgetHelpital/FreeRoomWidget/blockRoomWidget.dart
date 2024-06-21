import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonContact.dart';

import '../../../../Models/Rooms/Room.dart';
import '../../../Rooms/infoElementOfRooms.dart';

class BlockFreeRoomWidget extends StatelessWidget {
  Room room;
  BlockFreeRoomWidget({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoElementOfRoom(room: room)));
      },
      child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: HelpitalColors.myColorTextGreyClair
          ),
          height: SizeCustom().assignHeight(context: context, fraction: 0.3),
          width: SizeCustom().assignWidth(context: context, fraction: 0.3),
          child: Center(
            child: Column(
              children: [
                buildTop(context),
                Container(
                  height: SizeCustom().assignHeight(context: context, fraction: 0.005),
                  color: HelpitalColors.white,
                ),
                buildBottom(context)

              ],
            ),
          )
      ),
    );
  }
  Widget buildTop(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      height: SizeCustom().assignHeight(context: context, fraction: 0.07),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          ),
          color: HelpitalColors.green
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              room.title,
              style: TextStyle(
                  color: HelpitalColors.white,
                  fontSize: SizeCustom().assignTextSize(context: context, sizeText: room.title.length, size: 20)
              ),
            ),
            Text(room.service.title),
          ],
        ),
      ),
    );
  }
  Widget buildBottom(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: SizeCustom().assignHeight(context: context, fraction: 0.15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              room.floor.toString() + ' étages',
              style: TextStyle(
                  fontSize: 13
              ),

            ),
            Text(
              room.patients.length.toString() + ' / ' + room.capacity.toString(),
              style: TextStyle(
                  fontSize: 30
              ),

            ),
       /*     MyButtonContact(
              onClick: () {

              },
              color: HelpitalColors.yellow,
              icon: Icon(Icons.add)
            )*/
          ],
        )
      )
    );
  }
}
