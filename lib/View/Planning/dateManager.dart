import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Planning/myCalendar.dart';
import 'package:intl/intl.dart';

class DateManager extends StatefulWidget {
  Function(DateTime) getCurrentDay;
  DateTime day;


  DateManager({
    @required this.getCurrentDay,
    this.day
  });

  @protected
  _DateManagerState createState() => _DateManagerState(
        getCurrentDay: this.getCurrentDay,
        day: this.day
      );
}

class _DateManagerState extends State<DateManager> {
  Function(DateTime) getCurrentDay;
  DateTime day;
  double sizeButton;

  double minSize;
  double maxSize;
  _DateManagerState({
    @required this.getCurrentDay,
    this.day
  });

  bool calendarButtonAreaIsOpen = false;

  Widget dateContainer;
  List<DateTime> month = [];

  @protected
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    minSize = size.height * 0.05;
    maxSize = size.height * 0.3;
    if (sizeButton == null) sizeButton = minSize;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  var prevDay = day.subtract(new Duration(days: 1));
                  day = prevDay;
                  getCurrentDay(day);
                });
              },
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  child: buildButtonCalendar(context),
                ))),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {
                  setState(() {
                    var nextDay = day.add(new Duration(days: 1));
                    day = nextDay;
                    this.getCurrentDay(day);
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget buildButtonCalendar(context) {
    return AnimatedContainer(
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 0),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(
          top: 7,
          left: 10,
          right: 10,

        ),
        height: sizeButton,
        decoration: BoxDecoration(
          color: HelpitalColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: HelpitalColors.black,
              offset: Offset(0.0, 1.0),
              blurRadius: 1,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: ClipRect(
          child: buildSelecteNewDay(),
        ));
  }

  Widget buildSelecteNewDay() {
    return Container(
        padding: EdgeInsets.all(1),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    if (calendarButtonAreaIsOpen) {
                      sizeButton = minSize;

                      calendarButtonAreaIsOpen = false;
                    } else {
                      sizeButton = maxSize;

                      calendarButtonAreaIsOpen = true;
                    }
                  });
                },
                child: Container(
                  height: 20,
                  child: Text(
                    DateFormat("d MMMM y").format(this.day),
                    style: TextStyle(color: HelpitalColors.myColorTextIcon, fontSize: 15),
                  ),
                )),
            ClipRect(
              child: buildCalendar(context),
            )
          ],
        ));
  }

  Widget buildCalendar(context) {
      print('click');
        if (calendarButtonAreaIsOpen) {
          return MyCalendar(
            setCurrentDate: (newDate) {
              setState(() {

                sizeButton = minSize;
                calendarButtonAreaIsOpen = false;
                day = newDate;
                getCurrentDay(day);

              });
            },
            sizeButton: sizeButton,
            day: day,

          );
        } else {
          return Container(
            height: 1,
          );
        }

    }
}
