import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Planning/Event.dart';
import 'package:helpital_mobile_app/Services/planningService.dart';
import '../../../../Utils/values.dart';

import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WPlanning/blockEventWidget.dart';
import 'package:intl/intl.dart';

class WidgetPlanning extends StatefulWidget {
  const WidgetPlanning({Key key}) : super(key: key);

  @override
  _WidgetPlanningState createState() => _WidgetPlanningState();
}

class _WidgetPlanningState extends State<WidgetPlanning> {
  DateTime day;
  List<Event> listEvent = [];
  String languageCode;

  _WidgetPlanningState() {
    if (day == null) day = DateTime.now();
    languageCode = "fr";
    String from = DateFormat("y-M-d").format(day);
    String to = DateFormat("y-M-d").format(day.add(const Duration(days: 1)));
    PlanningService().getPlanningOfTheDay(from, to).then((value) {
      setState(() {
        listEvent = value;
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
                color: Colors.grey.withOpacity(0.5),
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
            Expanded(flex: 4, child: buildTop(context)),
            Expanded(flex: 6, child: buildBottom(context))
          ],
        ),
      ),
    );
  }
  Widget buildTop(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: buildTitle(context)
        ),
        Expanded(
          flex: 3,
          child: buildDay(context)
        ),
        Expanded(
            flex: 3,
            child: buildDateEnd(context)
        )
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(
            right: 30,
            bottom: 60
        ),

        child:  Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5
          ),
          decoration: BoxDecoration(
              color: HelpitalColors.myColorThird,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              )
          ),
          child: Center(
            child: Text(
              'Planning',
              style: TextStyle(
                  fontSize: 11,
                  color: HelpitalColors.white
              ),
            ),
          )
        )
    );
  }
  Widget buildDay(BuildContext context) {
    return Container(
        height: double.infinity,

        child: Center(
          child: Text(
            DateFormat("EEEE").format(day),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HelpitalColors.black,
                fontSize: 30
            ),
          ),
        )
    );
  }
  Widget buildDateEnd(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Text(
              DateFormat("d").format(day),
              style: TextStyle(
                  color: HelpitalColors.black,
                  fontSize: 40
              ),
            ),
            Text(
              DateFormat("MMMM").format(day),
              style: TextStyle(
                  color: HelpitalColors.black,
                  fontSize: 15

              ),
            ),
          ],
        )
    );
  }
  Widget buildBottom(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: viewportConstraints.maxWidth
                ),
                child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listEvent.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: new Material(
                                  color: Colors.transparent,
                                  child: BlockEventWidget(event: listEvent[index])
                              ),
                            ),
                          ),
                        );
                      },
                    )),

              ));
        });
  }
}
