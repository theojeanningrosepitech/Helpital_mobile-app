import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/cookiesService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/View/Notification/notif.dart';
import 'package:helpital_mobile_app/View/Plan/plan.dart';
import 'package:helpital_mobile_app/View/Planning/planning.dart';
import 'package:helpital_mobile_app/View/Profil/profil.dart';
import 'package:helpital_mobile_app/View/dashboard/dashboard.dart';

import 'package:helpital_mobile_app/Widgets/Buttons/myBottomBarNavigation.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonClass.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myRouteBuilder.dart';

import '../Utils/icons.dart';
import 'Directory/directory.dart';
import 'Inventory/inventory.dart';
import 'Message/message.dart';
import 'Note/note.dart';
import 'Meeting/meeting.dart';
import 'Patient/patientPage.dart';
import 'Rooms/rooms.dart';
import 'ScanQrCode/scanQrCode.dart';
import 'WaitingRooms/waitingRooms.dart';

class Core extends StatefulWidget {
  const Core({Key key}) : super(key: key);

  _CoreState createState() => _CoreState();
}

class _CoreState extends State<Core> {
  int _page = 0;
  int _index = 0;
  List<String> _listFavorie;
  _CoreState() {
    CookiesService().getFavorisList().then((value) => setState(() => _listFavorie = value));
  }
  List<StatefulWidget> _widgetOptions = <StatefulWidget>[];

  List<MyButton> listButtonMenu = [];
  bool pageHasChange = false;

  void generateListMenu() {
    listButtonMenu = [];
    _widgetOptions = <StatefulWidget>[];
    listButtonMenu.add(
      MyButton(
          icon: Icons.home,
          title: 'Home',
          index: 0
      ),
    );
    _widgetOptions.add(Dashboard());
    listButtonMenu.add(
      MyButton(
          icon: Icons.sick_sharp,
          title: 'Patients',
          index: 1
      ),
    );
    _widgetOptions.add(PatientPage());
    listButtonMenu.add(
      MyButton(
          icon: Icons.calendar_today_outlined,
          title: 'Tableaux de bord',
          index: 2
      ),
    );
    _widgetOptions.add(Planning());
    listButtonMenu.add(
      MyButton(
          icon: Icons.all_inbox,
          title: 'Inventaire',
          index: 3
      ),
    );
    _widgetOptions.add(InventoryPage());
    listButtonMenu.add(
      MyButton(
          icon: Icons.book,
          title: 'Annuaire',
          index: 4
      ),
    );
    _widgetOptions.add(Directory());
    listButtonMenu.add(
      MyButton(
          icon: Icons.map_outlined,
          title: 'Plan',
          index: 5
      ),
    );
    _widgetOptions.add(Plan());
    listButtonMenu.add(
      MyButton(
          icon: Icons.schedule_outlined,
          title: 'Réunion',
          index: 6
      ),
    );
    _widgetOptions.add(MeetingPage());
    listButtonMenu.add(
      MyButton(
          icon: Icons.meeting_room_outlined,
          title: 'Liste des chambres',
          index: 7
      ),
    );
    _widgetOptions.add(Rooms());
    listButtonMenu.add(
      MyButton(
          icon: Icons.note,
          title: 'Note',
          index: 8
      ),
    );
    _widgetOptions.add(Note());
    listButtonMenu.add(
      MyButton(
          icon: Icons.people,
          title: 'Salle d\'attente',
          index: 9
      ),
    );
    _widgetOptions.add(WaitingRooms());
    listButtonMenu.add(
      MyButton(
          icon: Icons.qr_code,
          title: 'Scanner',
          index: 10
      ),
    );
    _widgetOptions.add(ScanQrCode());

  }
  @override
  Widget build(BuildContext context) {
    if (_listFavorie != null) {
      generateListMenu();
     return Scaffold(
       extendBody: true,
       backgroundColor: HelpitalColors.myColorBackground,
       appBar: buildAppBar(context),
       body: buildBodyCore(context),
      );
    } else {
      return MyLoading();
    }
  }
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: HelpitalColors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: myProfileIcon,
        onPressed: () {
          Navigator.of(context)
              .push(MyRouteBuilder().createRoute(Profil(), -1.0, 0.0));
        },
      ),
      title: Image.asset(
        HelpitalAssets.HELPITAL,
        scale: 10,
      ),
      shape: ContinuousRectangleBorder(
        side:
            BorderSide(style: BorderStyle.solid, color: HelpitalColors.white.withOpacity(0.7)),
        /*borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90.0),
          bottomRight: Radius.circular(90.0),
        ),*/
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notification_important_outlined,
            color: HelpitalColors.myColorTextIcon,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.of(context)
                .push(MyRouteBuilder().createRoute(Notif(), 0.0, -1.0));
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.messenger_outline,
            color: HelpitalColors.myColorTextIcon,
          ),
          tooltip: 'Go to the next page',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Message()));
          },
        ),
      ],
    );
  }

  Widget buildBodyCore(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (_page != 3) {
      return Stack(
        children: [
          GestureDetector(

            onHorizontalDragUpdate: (details) {
              // Note: Sensitivity is integer used when you don't want to mess up vertical drag
              int sensitivity = 13;

              if (details.delta.dx > sensitivity) {
                Navigator.of(context)
                    .push(MyRouteBuilder().createRoute(Profil(), -1.0, 0.0));
              } else if (details.delta.dx < -sensitivity) {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => Message()));
              }
            },
            child: Container(
              height: size.height,
              child: _widgetOptions.elementAt(_page),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: buildNavBar(context))
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            height: size.height,
            child: _widgetOptions.elementAt(_page),
          ),
          Align(alignment: Alignment.bottomCenter, child: buildNavBar(context))
        ],
      );
    }
  }

  Widget buildNavBar(context) {
    return MyAppBarCustom(
      count: _page,
      onCountChanged: (index) {
        setState(() {
          _page = index;
        });
      },
      buttonWidget: listButtonMenu
    );
  }
}
