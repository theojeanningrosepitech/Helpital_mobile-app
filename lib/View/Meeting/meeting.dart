import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Meeting/Meeting.dart';
import 'package:helpital_mobile_app/Services/meetingServices.dart';
import 'package:helpital_mobile_app/View/Meeting/createMeeting.dart';
import 'package:helpital_mobile_app/View/Meeting/meetingTile.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../Widgets/UtilsWidgets/myErrorWidget.dart';

class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  List<Meeting> meetingList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: MeetingService().getMeetingList(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              meetingList = snapshot.data;
              if (meetingList != null) {
                return Expanded(
                  child: AnimationLimiter(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(25),
                          child: ElevatedButton(
                            child: Text(
                              "Créer un compte rendu",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                Colors.red,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateMeeting(),
                                ),
                              );
                            },
                          ),
                        ),
                      ] +
                          meetingList.map<Widget>(
                                (meeting) {
                              return (MeetingTile(
                                meeting: meeting,
                              ));
                            },
                          ).toList(),
                    ),
                  ),
                );
              } else {
                return Text('data  null');
              }
            }
          },
        ),
      ),
    );
  }
}
