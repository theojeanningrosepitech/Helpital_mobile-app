import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class InfoEvent extends StatelessWidget {
  String hour;
  String duringTime;
  String title;
  String description;
  double height;
  Color status;
  VoidCallback onDoubleTap;
  VoidCallback onLongPressUp;


  InfoEvent({this.title, this.hour, this.duringTime, this.description, this.status, this.onDoubleTap, this.onLongPressUp, this.height});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onLongPressUp: this.onLongPressUp,
        onDoubleTap: this.onDoubleTap,
        child: Container(
          height: height,
          width: size.width,

          decoration: BoxDecoration(
            color: HelpitalColors.myColorTextGreyClair,
            borderRadius:
            const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: build1stPartOfBlock(context)
              ),
              Expanded(
                  flex: 5,
                  child: build2ndPartOfBlock(context)
              ),
            ],
          ),
        ));
  }
  Widget build1stPartOfBlock(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      //constraints: BoxConstraints.expand(),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
        color: HelpitalColors.myColorFourth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,

            child: Text(
              hour,
              style: TextStyle(
                color: HelpitalColors.white,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(duringTime,
                style: TextStyle(
                  color: HelpitalColors.white,
                  fontSize: 10,
                )
            ),
          )
        ],
      ),
    );
  }
  Widget build2ndPartOfBlock(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width*0.4,
            padding: EdgeInsets.all(5),
            alignment: Alignment.topLeft,
            child: Column(
              children: [
              Expanded(
              flex: 1,
              child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15, color: HelpitalColors.black),
                ),),
                Expanded(
                  flex: 1,
                  child:
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 15, color: HelpitalColors.black,
                  )
                ),
                )
              ],
            )
          ),

          Container(
            padding: EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: status,
            ),
          )
        ],
      ),
    );
  }
}
