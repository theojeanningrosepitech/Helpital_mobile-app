import 'package:flutter/material.dart';

import '../../../../Models/Inventory/Inventory.dart';
import '../../../../Utils/values.dart';
import '../../../Inventory/infoElementOfInventory.dart';

class BlockInfoInventoryWidget extends StatelessWidget {
  Inventory inventory;
  BlockInfoInventoryWidget({Key key, this.inventory}) : super(key: key);
  Color status;
  String cleanTypeName(String name) {
    return name.replaceAll('_', ' ');
  }


  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InfoElementOfInventory(inventory: inventory)));
        },
        child: Container(
          margin: EdgeInsets.all(5),
                width: size.width * 0.5,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: HelpitalColors.white,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(myDefaultBorderRadius)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        //constraints: BoxConstraints.expand(),
                        alignment: Alignment.centerLeft,

                        decoration: BoxDecoration(
                          color: HelpitalColors.myColorFourth,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(myDefaultBorderRadius),
                              bottomLeft:
                              Radius.circular(myDefaultBorderRadius)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                                fit: BoxFit.contain,
                                child: Container(
                                  padding: EdgeInsets.all(5),

                                  child:Text(
                                    inventory.title,
                                    style: TextStyle(
                                      color: HelpitalColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                            ),

                            FittedBox(
                                fit: BoxFit.contain,
                                child: Container(
                                  padding: EdgeInsets.all(5),

                                  child: Text(cleanTypeName(inventory.type.name),
                                      style: TextStyle(
                                        color: HelpitalColors.white,
                                        fontSize: 10,
                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: HelpitalColors.white,
                      width: 2,
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: HelpitalColors.myColorPrimary,
                            borderRadius: const BorderRadius.only(
                                topRight:
                                Radius.circular(myDefaultBorderRadius),
                                bottomRight:
                                Radius.circular(myDefaultBorderRadius)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      color: HelpitalColors.myColorThird,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(
                                              myDefaultBorderRadius)),
                                    ),
                                    child: Text(HelpitalStrings.QUANTITY,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: HelpitalColors.myColorTextGreyClair)),
                                  ),
                                  Text(
                                    inventory.quantity.toString() ,
                                    style: TextStyle(
                                        fontSize: 30, color: HelpitalColors.myColorTextGrey),
                                  )
                                ],
                              ),

                            ],
                          ),
                        ))
                  ],
                )
            )
        
    );
  }
}
