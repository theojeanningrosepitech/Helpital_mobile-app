import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Meeting/Meeting.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Meeting/meetingDetails.dart';

class MeetingTile extends StatefulWidget {
  final Meeting meeting;

  const MeetingTile({Key key, this.meeting}) : super(key: key);
  @override
  _MeetingTileState createState() => _MeetingTileState();
}

class _MeetingTileState extends State<MeetingTile> {
  @override
  Widget build(BuildContext context) {
    return (ListTile(
      title: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            color: HelpitalColors.myColorFourth,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.meeting.title,
            style: TextStyle(
              color: HelpitalColors.white,
              fontSize: 20,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeetingDetails(
                meeting: widget.meeting,
              ),
            ),
          );
        },
      ),
    ));
  }
}
