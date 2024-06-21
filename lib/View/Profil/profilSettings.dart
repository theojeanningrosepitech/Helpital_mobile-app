import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/View/Profil/PageSettings/politicOfConfidenciality.dart';
import 'package:helpital_mobile_app/View/Profil/PageSettings/favorisManager.dart';
import 'package:helpital_mobile_app/View/Profil/PageSettings/assistance.dart';
import 'package:helpital_mobile_app/View/Profil/PageSettings/notificationManager.dart';
import 'package:helpital_mobile_app/View/Profil/PageSettings/conditionOfUtilisation.dart';
import 'package:helpital_mobile_app/View/Profil/PageSettings/themeManager.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/mySwitchButton.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:provider/provider.dart';

import '../../Models/User/User.dart';
import '../../Models/Utils/ConnectionParameters.dart';
import '../../Services/stateManagerConnection.dart';
import '../../Services/stateManagerTypeOfUser.dart';
import '../../Widgets/UtilsWidgets/myRouteBuilder.dart';
import '../../Services/stateManager.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'PageSettings/modificationElemPage.dart';

class ProfilSettings extends StatefulWidget {
  User user;

  ProfilSettings({this.user});

  @override
  _ProfilSettingsState createState() => _ProfilSettingsState(user: this.user);
}

class _ProfilSettingsState extends State<ProfilSettings> {
  User user;
  _ProfilSettingsState({this.user});
  @override
  Widget build(BuildContext context) {
    if (user != null) {

      return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        appBar: buildAppBar(context),
        body: buildCore(context),
      );
    } else {
      return Scaffold(
        backgroundColor: HelpitalColors.myColorBackground,
        appBar: buildAppBar(context),
        body: MyLoading(),
      );
    }


  }

  Widget buildAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
        leading: Container(
            margin: EdgeInsets.only(right: 10),
            width: size.width * 0.1,
            height: size.width * 0.1,
            decoration: new BoxDecoration(
              color: HelpitalColors.myColorTextGreyClair,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              HelpitalAssets.HELPITAL_LOGO,
              scale: 12,
            )
        ),
        title: Column(
          children: [
            Text(
              (user.firstName ?? HelpitalStrings.UNDEFINED) + ' ' + (user.lastName ?? HelpitalStrings.UNDEFINED),
              style: TextStyle(color: HelpitalColors.myColorTextIcon),
            ),
            Text(
              user.userRole.toString(),
              style: TextStyle(color: HelpitalColors.myColorTextIcon, fontSize: 10),



            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: HelpitalColors.myColorTextGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
  }

  Widget buildCore(BuildContext context) {
    String email = user.email ?? '';
    String number = user.phone ?? '';
    String id = user.id.toString() ?? '';
    String password = '********';

    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                height: size.height,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    buildTitle(context, HelpitalStrings.ACCOUNT),
                    buildElement(context, id, false, null),
                    buildElement(context, password, false, null),
                    buildElement(context, email, true, TypeOfModification.Email),
                    buildElement(context, number, true, TypeOfModification.Phone),
                    buildTitle(context, HelpitalStrings.DISPLAY),
                    //buildElementSwitchButton(context, HelpitalStrings.DARK_MODE),
                    buildThemeButtonPage(context),
                    buildAssistanceButtonPage(context),
                    buildNotificationButtonPage(context),
                    buildFavoritButtonPage(context),
                    buildPoliticButtonPage(context),
                    buildConditionButtonPage(context),
                    MyButtonCustom(
                      name: HelpitalStrings.DISCONNECT,
                      onClick: () {
                        setState(() async {
                          await AuthService().logout();
                          context.read<StateManagerConnection>().unvalideConnection();
                          context.read<StateManagerTypeOfUser>().setUser(TypeOfUser.NoSelected);
                          context.read<StateManager>().disconnect();
                          Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
                        });
                      },
                    )

                  ],
                ),
              )));
    });
  }
  Widget buildThemeButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MyRouteBuilder().createRoute(ThemeManager(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Thème",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildFavoritButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MyRouteBuilder().createRoute(FavorisManager(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Favoris",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildAssistanceButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('test');
        Navigator.of(context).push(MyRouteBuilder().createRoute(Assistance(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Assistance",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('test');
        Navigator.of(context).push(MyRouteBuilder().createRoute(NotificationManager(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Gestion de Notifications",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildPoliticButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('test');
        Navigator.of(context).push(MyRouteBuilder().createRoute(PoliticOfConfidenciality(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Politique de confidentialités",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildConditionButtonPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('test');
        Navigator.of(context).push(MyRouteBuilder().createRoute(ConditionOfUtilisation(), 1.0, 0.0));
      },
      child: Container(
        padding: EdgeInsets.all(7),
        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Conditions D’utilisations De Services",
              style: TextStyle(
                fontSize: 15,
                color: HelpitalColors.myColorTextIcon,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildElement(BuildContext context, String name, bool isModifiable, TypeOfModification type) {
    var size = MediaQuery.of(context).size;
    if (!isModifiable) {
      return InkWell(
        child: Container(
          padding: EdgeInsets.all(7),
            width: size.width,
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 15, color: HelpitalColors.myColorTextIcon),
                ),

              ],
            )
        ),
      );
    } else {
      return  InkWell(
        onTap: () {
          print('test');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ModificationElemPage(name: name, type: type,)));
        },
          child:Container(
              padding: EdgeInsets.all(7),

              width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 15, color: HelpitalColors.myColorTextIcon),
            ),
           Icon(Icons.arrow_forward_ios_rounded, size: 15,),
            
          ],
        )
          )
      );
    }
  }
  Widget buildElementSwitchButton(BuildContext context, name) {
    var size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(7),

        width: size.width,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 15, color: HelpitalColors.myColorTextIcon),
            ),
            MySwitchButton(
              apply: false,
              onClick: (hasChange) {
                print('dot has change' + hasChange.toString());
              },
            ),


          ],
        )
    );
  }
 }
