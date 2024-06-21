import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Planning/Event.dart';
import 'package:helpital_mobile_app/Services/planningService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Planning/listOfEvent.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myCustomScrollView.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import 'dateManager.dart';
import 'formNewEvent.dart';

class Planning extends StatefulWidget {
  const Planning({Key key}) : super(key: key);

  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  DateTime day;
  List<Event> listEvent;

  _PlanningState() {
    if (day == null) day = DateTime.now();

  }

  List<Event> cleanListOfEvent() {
    List<Event> newList = [];
    listEvent.forEach((element) {
      if (day.day == element.beginAt.day &&
          day.month == element.beginAt.month &&
          day.year == element.beginAt.year) {
        newList.add(element);
        newList..sort((a, b) => a.beginAt.hour.compareTo(b.beginAt.hour));

      }
    });

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      body: Stack(
        children: [
          buildLoadCore(context),
          buildDateManager(context),
        ],
      ),
      bottomNavigationBar: Container(height: size.height * 0.1,),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<String>(
              context: context,
              builder: (BuildContext context) => FormNewEvent()
          );
          Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);

        },
        backgroundColor: HelpitalColors.myColorPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildLoadCore(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MyCustomScrollView(
      child: Container(
          height: size.height,
          child: FutureBuilder<List<Event>>(
            future: PlanningService().getPlanning(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return MyLoading();
              }
              if (snapshot.hasError) {
                return MyErrorWidget();
              } else {
                listEvent = snapshot.data;

                return buildListOfEvent(context);
              }
            },
          )),

    );
  }

  Widget buildListOfEvent(BuildContext context) {
    List<Event> newList = cleanListOfEvent();
    if (newList.length > 0) {
      return Center(
          child: ListOfEvent(
            listEvent: newList,
            currentDay: day,
          ));
    } else {
      return Container(
        child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Text(HelpitalStrings.NO_ACTIVITY_TODAY),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )),
      );
    }

  }

  Widget buildDateManager(BuildContext context) {
    return DateManager(
      day: day,
      getCurrentDay: (curentDay) {
        print('planning page ');
        setState(() {
          day = curentDay;
        });
      },
    );
  }
}
