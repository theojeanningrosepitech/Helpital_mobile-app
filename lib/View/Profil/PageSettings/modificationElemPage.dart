import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Note/stateDialog.dart';

enum TypeOfModification {
  Email,
  Phone,
}
class ModificationElemPage extends StatefulWidget {

  String name;
  TypeOfModification type;
  ModificationElemPage({Key key, this.name, this.type}) : super(key: key);

  @override
  _ModificationElemPageState createState() => _ModificationElemPageState(
    name: name,
    type: type
  );
}

class _ModificationElemPageState extends State<ModificationElemPage> {
  String name;
  TypeOfModification type;

  _ModificationElemPageState({this.name, this.type});

  String new1;
  String new2;

  String key;
  String path;
  @override
  Widget build(BuildContext context) {
    if (type == TypeOfModification.Email) {
      key = 'email';
      path = 'update-email';
    } else {
      key = 'phone';
      path = 'update-phone';
    }
    return Scaffold(
      backgroundColor: HelpitalColors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          SizedBox(height: 15,),
          MyTextFieldCustom(
              name: 'new $key',
              currentInput: (str) {
                setState(() {
                  new1 = str;
                });
              },
              icon: Icons.email,
          ),
          SizedBox(height: 15,),

          MyTextFieldCustom(
            name: 'comfirm new $key',
            currentInput: (str) {
              new2 = str;
            },
            icon: Icons.email,
          ),
        ],
      ),
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
    actions: [
      IconButton(
          onPressed: () async {
            if (new1 == new2) {
              bool result = await UserService().modifyElem(path, key, new1);
              if (result) {
                await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => StateDialog(
                      title:'Succée' ,
                      content: 'Votre $key a été modifié avec succée',
                      color: HelpitalColors.green,
                    )
                );
                Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
              }
            }
          },
          icon: Icon(Icons.send, color: HelpitalColors.myColorTextIcon,)
      )
    ],
  );
}
