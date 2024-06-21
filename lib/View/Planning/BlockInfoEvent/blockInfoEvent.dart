import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Planning/BlockInfoEvent/infoEvent.dart';

class BlockInfoEvent extends StatefulWidget {
  String hour;
  String duringTime;
  String title;
  String description;
  Color status;
  VoidCallback onDoubleTap;
  VoidCallback onLongPressUp;
  VoidCallback onLongPress;

  BlockInfoEvent({
    this.title,
    this.hour,
    this.duringTime,
    this.description,
    this.status,
  });
  @override
  _BlockInfoEventState createState() => _BlockInfoEventState(
    hour: this.hour,
    duringTime: this.duringTime,
    title: this.title,
    description: this.description,
    status: this.status,
  );
}

class _BlockInfoEventState extends State<BlockInfoEvent> {

  String hour;
  String duringTime;
  String title;
  String description;
  Color status;

  _BlockInfoEventState({
    this.title,
    this.hour,
    this.duringTime,
    this.description,
    this.status,
  });
  bool displayInfo = false;
  String dataSelected = "";

  double _height;
  double _width;
  Widget block;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    if (block == null && _height == null && _width == null) {
      block = buildLittleBlockInfo(context);
      _height = size.height * 0.10;
      _width = size.width;
    }

    return GestureDetector(
        onLongPress: () {
          setState(() {
            dataSelected = this.hour;
            _height = size.height * 0.5;
            block = buildInfoEvent(context);
          });
        },
        onLongPressUp: () {
          setState(() {
            _height = size.height * 0.10;
            block = buildLittleBlockInfo(context);
          });
        },
        onDoubleTap: () {
          setState(() {
            dataSelected = this.hour;
            _height = size.height * 0.5;
            block = buildInfoEvent(context);
          });
        },
            child: AnimatedContainer(
              width: _width,
              height: _height,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: HelpitalColors.myColorTextGreyClair,
                borderRadius:
                const BorderRadius.all(Radius.circular(10.0)),
              ),
              duration: const Duration(milliseconds: 250),
              child: block,
      )
    );
  }
  Widget buildLittleBlockInfo(BuildContext context) {
    return Row(
          children: [
            Expanded(
                flex: 2,
                child: build1stPartOfBlock(context)
            ),
            Expanded(
                flex: 5,
                child: build2ndPartOfBlock(context)
            )
          ],
        );
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15, color: HelpitalColors.black),
            ),
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

  Widget buildInfoEvent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    String _hour = dataSelected;
    String _duringTime = duringTime;
    String _title = title;
    String _description = description;
    Color _status = HelpitalColors.red;
      return InfoEvent(
        title: _title,
        hour: _hour,
        status: _status,
        description: _description,
        duringTime: _duringTime,
        onDoubleTap: () {
          setState(() {
            _height = size.height * 0.10;
            block = buildLittleBlockInfo(context);

          });
        },
      );
    }
}
