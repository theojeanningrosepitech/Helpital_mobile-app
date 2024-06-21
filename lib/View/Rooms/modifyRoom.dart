import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';


class ModifyRoom extends StatefulWidget {
  const ModifyRoom({Key key}) : super(key: key);

  @override
  _ModifyRoomState createState() => _ModifyRoomState();
}

class _ModifyRoomState extends State<ModifyRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      appBar: buildAppBar(context),
      body: buildCore(context),
    );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
    leading:  IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextGrey,),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(HelpitalStrings.MODIF_ROOM ,style: TextStyle(color: HelpitalColors.myColorTextIcon),),
    actions: [
  Image.asset(HelpitalAssets.HELPITAL_LOGO, scale: 10,),

    ],

  );
  Widget buildCore(BuildContext context) {
    String name = HelpitalStrings.ACTUAL_NAME;
    String type = HelpitalStrings.ACTUAL_TYPE;
    String capacity = HelpitalStrings.ACTUAL_CAPACITY;
    String supervisor = HelpitalStrings.ACTUAL_SUPERVISOR;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            SizedBox(height: 1,),

            MyTextFieldCustom(
              canEdit: true,
              name: name,
              icon: Icons.room,
              textObscure: false,
              currentInput: (input) {
                print(input);
                name = input;
              },
            ),
            MyTextFieldCustom(
              canEdit: true,
              name: type,
              icon: Icons.room_preferences,
              textObscure: false,
              currentInput: (input) {
                print(input);
                type = input;
              },
            ),
            MyTextFieldCustom(
              canEdit: true,
              name: capacity,
              icon: Icons.format_list_numbered,
              textObscure: false,
              currentInput: (input) {
                print(input);
                capacity = input;
              },
            ),
            MyTextFieldCustom(
              canEdit: true,
              name: supervisor,
              icon: Icons.perm_identity,
              textObscure: false,
              currentInput: (input) {
                print(input);
                supervisor = input;
              },
            ),
            MyButtonCustom(
                name: HelpitalStrings.SAVE,
                onClick: () {
                  print("ca passe modifié room");
                }),
            SizedBox(height: 1,)
          ],
        )
    );
  }

}

