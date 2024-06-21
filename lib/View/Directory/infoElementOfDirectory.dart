import 'package:flutter/material.dart';
import '../../../../Utils/values.dart';
import 'package:helpital_mobile_app/View/Message/infoElementOfConversation.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonContact.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myRouteBuilder.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';

import '../../Models/Conversation/conversation.dart';
import '../../Models/User/User.dart';
import '../../Services/conversationService.dart';

class InfoElementOfDirectory extends StatelessWidget {
  User user;
  InfoElementOfDirectory({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.white,
      appBar: buildAppBar(context),
      body: buildCore(context)
    );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,
    backgroundColor: HelpitalColors.white,
    shadowColor: HelpitalColors.red,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Center(child: Text(HelpitalStrings.FORM_PROFILE, style: TextStyle(color: HelpitalColors.myColorTextIcon),),),
    shape: ContinuousRectangleBorder(
      side: BorderSide(
          style: BorderStyle.solid,
          color: HelpitalColors.white.withOpacity(0.7)
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(90.0),
        bottomRight: Radius.circular(90.0),
      ),
    ),
  );

  Widget buildCore(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Image profilePicture = Image.asset(
      HelpitalAssets.HELPITAL_LOGO,
      scale: 3,
    );
    String name = user.firstName + ' ' + user.lastName;
    String poste = user.userRole;
    String service = user.service;
    String id = user.id.toString();
    String email = user.email;
    String number = user.phone;

    return Center(
      child: Container(

        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: HelpitalColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: new BoxDecoration(
                          color: HelpitalColors.myColorTextGreyClair,
                          shape: BoxShape.circle,
                        ),
                        child: profilePicture
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: HelpitalColors.myColorTextIcon,
                          fontSize: 25
                      ),
                    ),
                    Text(
                      service,
                      style: TextStyle(
                          color: HelpitalColors.myColorTextIcon,
                          fontSize: 15
                      ),
                    ),
                    Text(
                      poste,
                      style: TextStyle(
                          color: HelpitalColors.myColorTextIcon,
                          fontSize: 15
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    SizedBox(height: 1,),

                    MyTextFieldCustom(
                      canEdit: false,
                      name: id,
                      icon: Icons.perm_identity,
                      textObscure: false,
                      currentInput: (input) {
                        print(input);
                      },
                    ),
                    MyTextFieldCustom(
                      canEdit: false,
                      name: email,
                      icon: Icons.email_outlined,
                      textObscure: false,
                      currentInput: (input) {
                        print(input);
                      },
                    ),
                    MyTextFieldCustom(
                      canEdit: false,
                      name: number,
                      icon: Icons.phone,
                      textObscure: false,
                      currentInput: (input) {
                        print(input);
                      },
                    ),
                    SizedBox(height: 1,),
                    buildButtonContact(context),
                    SizedBox(height: 1,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildButtonContact(BuildContext context) {
    return MyButtonContact(
      icon: Icon(Icons.message_outlined, color: HelpitalColors.white,),
      color: HelpitalColors.green,
      onClick: () async {
        Conversation conv = await ConversationService().getConversation(user.id);

        Navigator.of(context).push(
            MyRouteBuilder().createRoute(
                InfoElementOfConversation(conversation: conv),
                1.0,
                0.0
            )
        );
      },
    );
  }
}

