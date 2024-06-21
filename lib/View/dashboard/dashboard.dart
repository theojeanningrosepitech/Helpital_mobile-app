import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WConversation/widgetConversationInfoProfil.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WInventory/widgetInventory.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WPlanning/widgetPlanning.dart';

import 'WidgetHelpital/FreeRoomWidget/widgetFreeRoom.dart';
import 'WidgetHelpital/FreeWaitingRoomWidget/widgetFreeWaitingRoom.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<Widget> listWidget;
  bool isRefreshing = false;
/*  Future<void> reload() {
    print('reload');
    listWidget = [];
    listWidget = [
      new WidgetPlanning(),
      new WidgetConversationInfoProfil(),
      new WidgetInventory(),
      WidgetFreeRoom(),
      Container(
        height: 200,
      )
    ];
  }*/
  @override
  Widget build(BuildContext context) {
    if (!isRefreshing) {
      return coreDashboard("GFDS",  [
        Container(height: 10,),
        WidgetPlanning(),
        WidgetConversationInfoProfil(),
        WidgetInventory(),
        WidgetFreeRoom(),
        WidgetFreeWaitingRoom(),

        Container(
          height: 200,
        )
      ]);
    } else {
      return coreDashboard("566666",  [
        Container(height: 10,),
        WidgetConversationInfoProfil(),
        WidgetPlanning(),
        WidgetInventory(),
        WidgetFreeWaitingRoom(),
        WidgetFreeRoom(),

        Container(
          height: 200,
        )
      ]);
    }
  }

  Widget coreDashboard(String test, List<Widget> list) {
    return RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          print(test);
          setState(() {
            //reload();
            isRefreshing = !isRefreshing;
          });
        },
        child: ListView(
          cacheExtent: 100.0,
          physics: const AlwaysScrollableScrollPhysics(),
          children: list,
        )

      /* ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: listWidget
            ),
          ),
        ),
      ),*/
    );
  }
}
