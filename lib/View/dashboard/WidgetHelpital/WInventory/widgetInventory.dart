import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Inventory/Inventory.dart';
import 'package:helpital_mobile_app/Services/inventoryService.dart';
import '../../../../Utils/values.dart';

import '../../../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../../Inventory/blockInfoInventory.dart';
import 'blockInfoInventoryWidget.dart';

class WidgetInventory extends StatefulWidget {
  const WidgetInventory({Key key}) : super(key: key);

  @override
  _WidgetInventoryState createState() => _WidgetInventoryState();
}

class _WidgetInventoryState extends State<WidgetInventory> {

  List<Inventory> listInventory = [];
  _WidgetInventoryState() {
    InventoryService().getInventoryList().then((value) {
      List<Inventory> bufferList = [];
      value.forEach((element) {
        if (element.quantity < 10) {
          bufferList.add(element);
        }
      });
      setState(() {
        listInventory = bufferList;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: size.height * 0.3,
        width: size.width ,
        decoration: BoxDecoration(
            color: HelpitalColors.white,
            boxShadow: [
              BoxShadow(
                color: HelpitalColors.black.withOpacity(0.5),
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
          children: [
            buildTitle(context),
            buildBottom(context)
          ],
        ),
      ),
    );
  }
  Widget buildTitle(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.centerLeft,
        child:  Container(
          height: size.height * 0.05,
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
            'Inventaire',
            style: TextStyle(
                fontSize: 16,
                color: HelpitalColors.white
            ),
          ),
        )
    );
  }
  Widget buildBottom(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
     child: MyListBuilder(
        list: listInventory,
        builder: (context, index) {
          return MyAnimationListBuilder(
            index: index,
            child: BlockInfoInventoryWidget(inventory: listInventory[index]),
          );
        },)
    );
  }
}
