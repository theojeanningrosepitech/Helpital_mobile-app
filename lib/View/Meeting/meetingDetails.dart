import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Models/Meeting/Meeting.dart';

import '../../Widgets/UtilsWidgets/myListBuilder.dart';

class MeetingDetails extends StatefulWidget {
  final Meeting meeting;

  const MeetingDetails({Key key, this.meeting}) : super(key: key);
  @override
  _MeetingDetailsState createState() => _MeetingDetailsState();
}

class _MeetingDetailsState extends State<MeetingDetails> {
  List<Widget> listWidget;
  @override
  Widget build(BuildContext context) {
    listWidget = [
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Titre :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Description :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.description,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Responsable :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.creator,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Participants :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.identity,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Notes :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.content,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Fichiers :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.file,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Dates :",
          style: TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        widget.meeting.updateDate,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ];
    if (listWidget != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Image.asset(
            'assets/h_logo1.png',
            scale: 10,
          ),
          shape: ContinuousRectangleBorder(
            side: BorderSide(
              style: BorderStyle.solid,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: MyListBuilder(
              list: listWidget,
              builder: (context, index) {
                return MyAnimationListBuilder(
                  index: index,
                  child: Center(
                    child: listWidget[index],
                  ),
                );
              },
            )
          ),
        ),
      );
    }
  }
}
