import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:intl/intl.dart';

import '../../../../Models/Planning/Event.dart';
import '../../../../Widgets/PatternPages/pageSettingsDefault.dart';
import '../../../../Widgets/UtilsWidgets/myLoading.dart';

class InfoEventWidget extends StatefulWidget {
  Event event;
  InfoEventWidget({Key key, this.event}) : super(key: key);

  @override
  _InfoEventWidgetState createState() => _InfoEventWidgetState(event: event);
}

class _InfoEventWidgetState extends State<InfoEventWidget> {
  Event event;
  DateTime day;
  _InfoEventWidgetState({this.event});
  @override
  Widget build(BuildContext context) {
    if (event != null) {
      if (day == null) day = DateTime.now();

      return PageSettingsDefault(
        action: [

        ],
        name: event.title,
        child: buildCore(context)

    );
    } else {
      return MyLoading();
    }
  }
  
  Widget buildCore(BuildContext context) {
    String _hour = DateFormat("Hm").format(event.beginAt);
    String _duringTime = DateFormat("Hm").format(event.endAt);
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
                height: SizeCustom().assignHeight(context: context, fraction: 0.1),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: HelpitalColors.myColorTextGreyClair,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text(DateFormat("EEEE d MMMM").format(day), style: TextStyle(fontSize: 25),),
                )
            ),
            Container(
                height: SizeCustom().assignHeight(context: context, fraction: 0.3),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: HelpitalColors.myColorTextGreyClair,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_hour, style: TextStyle(fontSize: 25),),
                      Icon(Icons.arrow_forward_ios_rounded),
                      Text(_duringTime, style: TextStyle(fontSize: 25)),

                    ],),
                )
            ),

            Container(
              height: SizeCustom().assignHeight(context: context, fraction: 0.3),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: HelpitalColors.myColorTextGreyClair,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: Text(
                    event.description
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
