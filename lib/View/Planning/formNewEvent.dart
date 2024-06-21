import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/planningService.dart';
import 'package:intl/intl.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Widgets/UtilsWidgets/myCustomScrollView.dart';


class NewEvent {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;

  NewEvent({
    this.title,
    this.description,
    this.startDate,
    this.endDate
  });
}
class FormNewEvent extends StatefulWidget {

  const FormNewEvent({Key key}) : super(key: key);

  @override
  _FormNewEventState createState() => _FormNewEventState();
}

class _FormNewEventState extends State<FormNewEvent> {

  String title;
  String description;
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
  String textHolder = "";
  List<TextEditingController> controllers = [];


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un évenement'),
      content: MyCustomScrollView(
        child: buildCore()
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {

            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Annuler', textAlign: TextAlign.start, style: TextStyle(color: HelpitalColors.myColorSecondary),),
        ),
        TextButton(
          onPressed: () {
            PlanningService().setNewEvent(NewEvent(
                title: title,
                description: description,
                endDate: dateEnd,
                startDate: dateStart
            ));
            Navigator.pop(context, HelpitalStrings.REGISTER);
          },
          child: Text(HelpitalStrings.REGISTER, style: TextStyle(color: HelpitalColors.myColorPrimary),),
        ),
      ],
    );
  }

  Widget buildCore() {
    return Container(
      height: 400,
      child: Column(
        children: [
          MyFormField(
            name: 'Titre',
            currentInput: (str) {
              setState(() {
                title = str;
              });
            },
          ),
          MyFormField(
            name: 'Description',
            currentInput: (str) {
              setState(() {
                description = str;
              });
            },
          ),

          DateSetter(
            title: 'Début',

            date: dateStart,
            getDate: (date) {
                setState(() {
                  dateStart = date;
                });
            },
          ),
      DateSetter(
        title: 'Fin',
          date: dateEnd,
          getDate: (date) {
    setState(() {
    dateEnd = date;
    });
    },
          ),
        ],
      ),
    );
  }


}

class MyFormField extends StatelessWidget {
  final String name;
  final Function(String) currentInput;

  const MyFormField({this.name, this.currentInput});

  @override
  Widget build(BuildContext context) {
      return TextFormField(
        maxLines: null,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: name,
        ),
        onSaved: (str) {
          currentInput(str);
        },
        onChanged: (str) {
          currentInput(str);
        },
      );

  }
}

class DateSetter extends StatelessWidget {
  DateTime date;
  String title;
  Function(DateTime) getDate;
  DateSetter({this.date, this.title, this.getDate});
  TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    time = TimeOfDay.now();
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(title ?? '',
                  style: TextStyle(
                      color: HelpitalColors.myColorTextIcon)
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: FittedBox(
              fit: BoxFit.contain,
              child: ElevatedButton(
                child:  FittedBox(
    fit: BoxFit.contain,
    child: FittedBox(
    fit: BoxFit.contain,
    child: Text(
                  DateFormat("d/MM/yy").format(date),
                ),
    ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                onPressed: () {
                  _selectDate(context);
                },
              )
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: FittedBox(
                fit: BoxFit.contain,
                child: ElevatedButton(
                  child:  FittedBox(
                    fit: BoxFit.contain,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        DateFormat("h:m").format(date),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _selectTime(context);
                  },
                )
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: HelpitalColors.myColorPrimary, colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(
            0xFFFF3232,
            const <int, Color>{
              50: HelpitalColors.myColorPrimary,
              100: HelpitalColors.myColorPrimary,
              200: HelpitalColors.myColorPrimary,
              300: HelpitalColors.myColorPrimary,
              400: HelpitalColors.myColorPrimary,
              500: HelpitalColors.myColorSecondary,
              600: HelpitalColors.myColorSecondary,
              700: HelpitalColors.myColorSecondary,
              800: HelpitalColors.myColorSecondary,
              900: HelpitalColors.myColorSecondary,
            },
          )).copyWith(secondary: HelpitalColors.myColorPrimary)//selection color
            //dialogBackgroundColor: Colors.white,//Background color
          ),
          child: child,
        );
      },
    );
    if (time != null && time != date) {
      date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      getDate(date);
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: HelpitalColors.myColorPrimary, colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(
            0xFFFF3232,
                const <int, Color>{
                  50: HelpitalColors.myColorPrimary,
                  100: HelpitalColors.myColorPrimary,
                  200: HelpitalColors.myColorPrimary,
                  300: HelpitalColors.myColorPrimary,
                  400: HelpitalColors.myColorPrimary,
                  500: HelpitalColors.myColorSecondary,
                  600: HelpitalColors.myColorSecondary,
                  700: HelpitalColors.myColorSecondary,
                  800: HelpitalColors.myColorSecondary,
                  900: HelpitalColors.myColorSecondary,
                },
              )).copyWith(secondary: HelpitalColors.myColorPrimary)//selection color
            //dialogBackgroundColor: Colors.white,//Background color
          ),
          child: child,
        );
      },
    );
    if (pickedDate != null && pickedDate != date) {
        date = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 12);
        getDate(date);
      }
  }


}
