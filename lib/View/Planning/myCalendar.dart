import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatelessWidget {
  double sizeButton;
  DateTime day;
  Function(DateTime) setCurrentDate;
  MyCalendar({
    this.sizeButton,
    this.day,
    this.setCurrentDate
});

  int currentDayNumber;

  List<Widget> mon = [];
  List<Widget> tue = [];
  List<Widget> wed = [];
  List<Widget> thu = [];
  List<Widget> fri = [];
  List<Widget> sat = [];
  List<Widget> sun = [];


  void getAllDaysOfTheMonth() {
    DateTime buf;
    for (int i = 1; i <= DateUtils.getDaysInMonth(day.year, day.month); i++) {
      buf = DateTime(day.year, day.month, i);
      switch (DateFormat("E").format(buf)) {
        case 'Mon': {
          if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
            tue.add(buildEmpty());
            wed.add(buildEmpty());
            thu.add(buildEmpty());
            fri.add(buildEmpty());
            sat.add(buildEmpty());
            sun.add(buildEmpty());
          }
          mon.add(buildDay(i));
          break;
        }
        case 'Tue': {
          if (i == 1) {
            mon.add(buildEmpty());
          }
          if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
            wed.add(buildEmpty());
            thu.add(buildEmpty());
            fri.add(buildEmpty());
            sat.add(buildEmpty());
            sun.add(buildEmpty());
          }
          tue.add(buildDay(i));
          break;
        }
        case 'Wed': {
          if (i == 1) {
            mon.add(buildEmpty());
            tue.add(buildEmpty());
          }
          if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
            thu.add(buildEmpty());
            fri.add(buildEmpty());
            sat.add(buildEmpty());
            sun.add(buildEmpty());

          }
          wed.add(buildDay(i));
          break;
        }
        case 'Thu':
          {
            if (i == 1) {
              mon.add(buildEmpty());
              tue.add(buildEmpty());
              wed.add(buildEmpty());
            }
            if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
              fri.add(buildEmpty());
              sat.add(buildEmpty());
              sun.add(buildEmpty());

            }
            thu.add(buildDay(i));
            break;
          }
        case 'Fri':
          {
            if (i == 1) {
              mon.add(buildEmpty());
              tue.add(buildEmpty());
              wed.add(buildEmpty());
              thu.add(buildEmpty());
            }
            if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
              sat.add(buildEmpty());
              sun.add(buildEmpty());

            }
            fri.add(buildDay(i));
            break;
          }
        case 'Sat':
          {
            if (i == 1) {
              mon.add(buildEmpty());
              tue.add(buildEmpty());
              wed.add(buildEmpty());
              thu.add(buildEmpty());
              fri.add(buildEmpty());
            }
            if (i == DateUtils.getDaysInMonth(day.year, day.month)) {
              sun.add(buildEmpty());

            }
            sat.add(buildDay(i));
            break;
          }
        case 'Sun':
          {
            if (i == 1) {
              mon.add(buildEmpty());
              tue.add(buildEmpty());
              wed.add(buildEmpty());
              thu.add(buildEmpty());
              fri.add(buildEmpty());
              sat.add(buildEmpty());
            }
            sun.add(buildDay(i));
            break;
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mon = [];
    tue = [];
    wed = [];
    thu = [];
    fri = [];
    sat = [];
    sun = [];
    currentDayNumber = day.day;
    getAllDaysOfTheMonth();

    return Container(
      height: sizeButton * 0.80,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(HelpitalStrings.L),
                SizedBox(),
                Text(HelpitalStrings.Ma),
                SizedBox(),
                Text(HelpitalStrings.Mer),
                SizedBox(),
                Text(HelpitalStrings.J),
                SizedBox(),
                Text(HelpitalStrings.V),
                SizedBox(),
                Text(HelpitalStrings.S),
                SizedBox(),
                Text(HelpitalStrings.D),
                SizedBox(),

              ],
            ),
          ),
          SizedBox(height: 5,),
          buildColumn(),
        ],
      ),
    );
  }

  Widget buildColumn() {
    return Container(
      height: sizeButton * 0.7,
      child: Row(
        children: [
          SizedBox(),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: mon,
              )),
          SizedBox(),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: tue,
              )),
          SizedBox(),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: wed,
              )),
          SizedBox(),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: thu,
              )),
          SizedBox(),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: fri,
              )),
          SizedBox(),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: sat,
              )),
          SizedBox(),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: sun,
            ),)
        ],
      ),
    );
  }

  Widget buildDay(nmb) {
    var color = HelpitalColors.myColorPrimary;
    if (nmb == currentDayNumber) {
      color = HelpitalColors.myColorTextIcon;
    }
    return InkWell(
        onTap: () {
          DateTime newDate = DateTime(day.year, day.month, nmb);
          setCurrentDate(newDate);
        },
        child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  nmb.toString(),
                  style: TextStyle(fontSize: 10, color: HelpitalColors.white),
                ),
              ),
            )
        )
    );
  }
  Widget buildEmpty() {
    return Container(
      height: 25,
      width: 25,
    );
  }
}



