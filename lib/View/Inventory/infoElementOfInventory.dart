import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Inventory/Inventory.dart';
import 'package:helpital_mobile_app/Services/inventoryService.dart';
import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/Widgets/Buttons/myButtonClass.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonContact.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../Models/Rooms/Room.dart';

class InfoElementOfInventory extends StatefulWidget {
  Inventory inventory;

  InfoElementOfInventory({this.inventory});

  @override
  _InfoElementOfInventoryState createState() =>
      _InfoElementOfInventoryState(inventory: this.inventory);
}

class _InfoElementOfInventoryState extends State<InfoElementOfInventory> {
  Inventory inventory;
  Room room;
  _InfoElementOfInventoryState({this.inventory}) {
    RoomsService().getRoom(inventory.roomId).then((value) {
      setState(() {
        room = value;
      });
    });
  }
  int newQuantity = 0;

  void changeValueNewQuantity(newValue) {
    setState(() {
      newQuantity = newQuantity + newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) => AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
        shadowColor: HelpitalColors.red,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: HelpitalColors.myColorTextIcon,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            inventory.title,
            style: TextStyle(color: HelpitalColors.myColorTextIcon),
          ),
        ),
        shape: ContinuousRectangleBorder(
          side: BorderSide(
              style: BorderStyle.solid, color: HelpitalColors.white.withOpacity(0.7)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(90.0),
            bottomRight: Radius.circular(90.0),
          ),
        ),
      );

  Widget buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        buildBlockInfoObj(context, size.height * 0.15),
        buildBlockStockageObj(context, size.height * 0.3),
        //buildBlockSManageObject(context, size.height * 0.3)
      ],
    );
  }

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
          buildMyRow('Numéro:', inventory.id.toString()),
          buildMyRow('Type:', inventory.type.name.replaceAll('_', ' ')),
        ],
      ),
    );
  }

  Widget buildBlockStockageObj(BuildContext context, size) {
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
            flex: 1,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10

                  ),
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorThird,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    HelpitalStrings.STOCKAGE,
                    style: TextStyle(
                      color: HelpitalColors.white,
                      fontSize: 20,
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
            flex: 5,
            child: buildBlockRoom(context)
          )
        ],
      ),
    );
  }


  Widget buildBlockRoom(BuildContext context) {
    if (room != null) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildMyRow('Salle:', room.title ?? ' '),
            buildMyRow('Type:', room.type.title ?? ' '),
            buildMyRow('Étage:', room.floor.toString() ?? ' '),
            buildMyRow('Service:', room.service.title ?? ' '),
          ],
        ),
      );
    } else {
      return MyLoading();
    }
  }

  Widget buildBlockSManageObject(BuildContext context, size) {
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
            flex: 1,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10

                  ),
                  decoration: BoxDecoration(
                      color: HelpitalColors.myColorThird,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    "Gérer les stocks",
                    style: TextStyle(
                      color: HelpitalColors.white,
                      fontSize: 20,
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
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMyRow('Quantité:', inventory.quantity.toString() ?? ' '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButtonContact(
                        icon: Icon(Icons.remove),
                        color: HelpitalColors.myColorPrimary,
                        onClick: () => changeValueNewQuantity(-1),
                      ),
                      Container(
                        child: Text(newQuantity.toString(), style: TextStyle(
                            fontSize: 30
                        ),),
                      ),
                      MyButtonContact(
                        icon: Icon(Icons.add),
                        color: HelpitalColors.green,
                        onClick: () => changeValueNewQuantity(1),

                      ),
                    ],
                  ),
                  MyButtonCustom(
                      name: 'Ajoutée',
                      onClick: () {

                      }
                  )
                ],
              )
            ),
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
        style: TextStyle(fontSize: 20, color: _color),
      );
}
