import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WPlanning/infoEventWidget.dart';
import 'package:intl/intl.dart';

import '../../../../Models/Planning/Event.dart';
import '../../../../Utils/values.dart';

class BlockEventWidget extends StatelessWidget {
  Event event;
  BlockEventWidget({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoEventWidget(event: event))
      );
    },
    child: Container(
      padding: EdgeInsets.all(10),
      height: 50,
      width: 120,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: HelpitalColors.secondaryGradientColors,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: buildTop(context)
            ),
            Container(
              color: HelpitalColors.white,
              height: 3,
            ),
            Expanded(
                flex: 4,
                child: buildBottom(context)
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget buildTop(BuildContext context) {
    String _hour = DateFormat("Hm").format(event.beginAt);
    String _duringTime = ((event.duration/60 /60).toInt()).toString() + ' heure' ;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: HelpitalColors.primaryGradientColors,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              _hour.toString(),
              style: TextStyle(
                  color: HelpitalColors.white,
                  fontSize: 15
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              _duringTime.toString(),
              style: TextStyle(
                  color: HelpitalColors.white,
                  fontSize: 15
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
      )
    );
  }
  Widget buildBottom(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Center(
        child: Text(event.title),
      )
    );
  }
}
