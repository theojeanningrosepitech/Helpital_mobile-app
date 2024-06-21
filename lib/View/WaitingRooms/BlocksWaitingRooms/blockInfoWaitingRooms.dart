import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';


class BlockInfoWaitingRooms extends StatelessWidget {
  String name;
  String step;
  String quantity;
  String maxQuantity;
  VoidCallback onClickElem;
  VoidCallback onClickButton;

  BlockInfoWaitingRooms({
    this.name,
    this.step,
    this.quantity,
    this.maxQuantity,
    this.onClickElem,
    this.onClickButton,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return InkWell(
        onTap: this.onClickElem,
        child: ListTile(
            title: Container(
                width: size.width,
                height: size.height * 0.11,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: HelpitalColors.black,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 3,
                    ),
                  ],
                  color: HelpitalColors.white,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(myDefaultBorderRadius)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: build1stPartBlock(context),
                    ),
                    Container(
                      color: HelpitalColors.white,
                      width: 2,
                    ),
                    Expanded(
                        flex: 4,
                        child: build2ndPartBlock(context),
                    )
                  ],
                ))));
  }

  Widget build1stPartBlock(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
        color: HelpitalColors.myColorFourth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(myDefaultBorderRadius),
            bottomLeft:
            Radius.circular(myDefaultBorderRadius)),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,

            child: Text(
              name,
              style: TextStyle(
                color: HelpitalColors.white,
                fontSize: -name.length * 0.5 + 20,
              ),
            ),
          ),
      Container(
        alignment: Alignment.centerLeft,

        child: Text(step,
              style: TextStyle(
                color: HelpitalColors.white,
                fontSize: 10,
              )
        )
      )
        ],
      ),
    );
  }

  Widget build2ndPartBlock(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      decoration: BoxDecoration(
        color: HelpitalColors.myColorTextGreyClair,
        borderRadius: const BorderRadius.only(
            topRight:
            Radius.circular(myDefaultBorderRadius),
            bottomRight:
            Radius.circular(myDefaultBorderRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    color: HelpitalColors.myColorFourth,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: HelpitalColors.myColorThird,
                        borderRadius: const BorderRadius
                            .only(
                            bottomRight: Radius.circular(
                                myDefaultBorderRadius)),
                      ),
                      child: Text(HelpitalStrings.QUANTITY,
                          style: TextStyle(
                              fontSize: 13,
                              color: HelpitalColors.myColorTextGreyClair)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025,),
                  Container(
                    alignment: Alignment.bottomCenter,

                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: HelpitalColors.myColorTextGrey),
                    ),
                  )

                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: HelpitalColors.myColorFourth,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(
                              myDefaultBorderRadius)),
                    ),
                    child: Text(HelpitalStrings.NMB_PEOPLE_MAX,
                        style: TextStyle(
                            fontSize: 13,
                            color: HelpitalColors.myColorTextGreyClair)),
                  ),
                  SizedBox(height: size.height * 0.025,),

                  Container(
                    child: Text(
                      maxQuantity,
                      style: TextStyle(
                          fontSize: 30,
                          color: HelpitalColors.myColorTextGrey),
                    ),
                  )

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
