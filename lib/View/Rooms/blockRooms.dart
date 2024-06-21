import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Rooms/Room.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myRouteBuilder.dart';
import 'infoElementOfRooms.dart';
import 'modifyRoom.dart';

class BlocksRooms extends StatelessWidget {
  Room room;

  BlocksRooms({this.room});

  String name;
  String step;
  String quantity;
  String maxQuantity;

  @override
  Widget build(BuildContext context) {
    name = room.title;
    step = room.floor.toString();
    quantity = room.patients.length.toString();
    maxQuantity = room.capacity.toString();

    return Container(
        padding: EdgeInsets.all(10),
        width: 170,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoElementOfRoom(room: room)));
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: HelpitalColors.black,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3,
                ),
              ],
              color: HelpitalColors.myColorTextGreyClair,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildTitle(context),
                    buildContent(context),
                  ],
                ),
                buildButtonModif(context),
                SizedBox(height: 5,)

              ],
            ),
          ),
        ));
  }
  Widget buildTitle(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: HelpitalColors.myColorFourth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
        Expanded(
        flex: 7,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.contain,
            child:  Text(
              name,
              style: TextStyle(
                color: HelpitalColors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
          Expanded(
              flex: 1,
              child:
              Text(
        step + 'E',
        style: TextStyle(
          color: HelpitalColors.white,
          fontSize: 10,
        ),))

        ],
      ),
    );
  }
  Widget buildContent(BuildContext context) {
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(

            child: Column(
              children: [
                Container(
                  color: HelpitalColors.myColorFourth,

                  child: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5),

                    decoration: BoxDecoration(
                      color: HelpitalColors.myColorThird,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Text(HelpitalStrings.QUANTITY,
                        style: TextStyle(
                            fontSize: 13,
                            color: HelpitalColors.myColorTextGreyClair)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),


                  decoration: BoxDecoration(
                    color: HelpitalColors.myColorFourth,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Text(HelpitalStrings.NMB_PEOPLE_MAX,
                      style: TextStyle(
                          fontSize: 13,
                          color: HelpitalColors.myColorTextGreyClair)),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  quantity,
                  style: TextStyle(
                      fontSize: 13, color: HelpitalColors.myColorTextIcon),
                ),
                Text(
                  maxQuantity,
                  style: TextStyle(
                      fontSize: 13, color: HelpitalColors.myColorTextIcon),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
  Widget buildButtonModif(BuildContext context) {
    return  Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: HelpitalColors.green,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: HelpitalColors.black,
                offset: Offset(0.0, 1.0),
                blurRadius: 1,
              ),
            ],
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0)
            )
        ),
        child: Center(
          child: IconButton(
              color: HelpitalColors.white,
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MyRouteBuilder().createRoute(ModifyRoom(), 1.0, 0.0));


              }),
        )
    );
  }
}
