import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';


class Notif extends StatefulWidget {
  const Notif({Key key}) : super(key: key);

  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Center(
        child: Text(
          'Page Notification',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Container(
        child: buildopenNavBarButton(),
      ),
    );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,

    shadowColor: HelpitalColors.white,
    backgroundColor: HelpitalColors.white,
    title: Image.asset(HelpitalAssets.HELPITAL, scale: 10,),

  );
  Widget buildopenNavBarButton() => InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Icon(
      Icons.arrow_drop_down_circle,
      color: HelpitalColors.myColorTextIcon,
    ),
  );
}
