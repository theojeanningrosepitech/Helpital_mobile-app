import 'package:flutter/material.dart';

import 'package:helpital_mobile_app/Utils/values.dart';

class PageSettingsDefault extends StatelessWidget {
  String name;
  Widget child;
  List<Widget> action = [];
  PageSettingsDefault({Key key, this.name, this.child, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: child
    );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
    shadowColor: HelpitalColors.red,
    title: Text(name, style: TextStyle(color: HelpitalColors.myColorTextIcon),),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
      tooltip: 'Show Snackbar',
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    //title: Center(child: Text(waitingRoom.title, style: TextStyle(color: HelpitalColors.myColorTextIcon),),),
    actions: action,
  );
}


