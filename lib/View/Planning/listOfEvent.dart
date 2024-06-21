import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Planning/Event.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myListBuilder.dart';
import 'package:intl/intl.dart';

import 'BlockInfoEvent/blockInfoEvent.dart';

class ListOfEvent extends StatelessWidget {

  List<Event> listEvent;
  DateTime currentDay;

  ListOfEvent({this.listEvent, this.currentDay});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
      return Container(
        height: size.height,
        child: OverflowBox(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                height: size.height*0.8,
                width: size.width,
                child: MyListBuilder(
                  list: listEvent,
                  builder: (context, index) {
                    return MyAnimationListBuilder(
                      index: index,
                      child: buildBlock(context, listEvent[index]),
                    );
                  },
                )
              )
            ],
          ),
        ),
      );
  }

  Widget buildBlock(BuildContext context, Event data) {
    String _hour = DateFormat("Hm").format(data.beginAt);
    String _duringTime = DateFormat("Hm").format(data.endAt);
    String _title = data.title;
    String _description = data.description;
    Color _status = HelpitalColors.red;

    return BlockInfoEvent(
      hour: _hour,
      duringTime: _duringTime,
      title: _title,
      description: _description,
      status: _status,
    );
  }
}
