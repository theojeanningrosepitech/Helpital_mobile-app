import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Services/conversationService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../Models/Conversation/conversation.dart';
import '../../Models/Message/message.dart';
import '../Directory/infoElementOfDirectory.dart';
import 'bodyMessage.dart';

class InfoElementOfConversation extends StatefulWidget {
  Conversation conversation;
  InfoElementOfConversation({this.conversation});


  @override
  _InfoElementOfConversationState createState() => _InfoElementOfConversationState(
      conversation: this.conversation
  );
}

class _InfoElementOfConversationState extends State<InfoElementOfConversation> {
  List<User> user;
  List<Message> listMessage;
  Conversation conversation;
  _InfoElementOfConversationState({this.conversation}) {
        ConversationService().getUserFromOneConversationList(this.conversation).then((listUser) {
          if (listUser != null) {
            setState(() {
              user = listUser;
            });
          }
        });
      }


  @override
  Widget build(BuildContext context) {
      if (conversation != null && user != null) {
        return Scaffold(
          appBar: buildAppBar(),
          body: BodyMessage(idConv: conversation.id, userReceiver: user,conv: conversation,),
        );
      } else {
        return Scaffold(
          appBar: buildAppBar(),
          body:  MyLoading()
        );
      }



  }

  AppBar buildAppBar() {
    if (user != null) {

    return AppBar(
      elevation: 0.0,

      backgroundColor: HelpitalColors.myColorTextGreyClair,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
            tooltip: 'Show Snackbar',
            onPressed: () {
              this.listMessage = null;
              this.conversation = null;
              this.user = null;
              Navigator.pop(context);
            },
          ),
          CircleAvatar(
            backgroundColor: HelpitalColors.myColorTextGreyClair,
            backgroundImage: AssetImage("assets/helpital_logo_heart.png"),
          ),
          SizedBox(width: myDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //this.user.firstName + ' ' + this.user.lastName
                conversation.title != null ? conversation.title : (user[1].firstName + ' ' + user[1].lastName),
                style: TextStyle(fontSize: 16, color: HelpitalColors.myColorTextIcon),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12, color: HelpitalColors.myColorTextIcon),
              )
            ],
          )
        ],
      ),
      actions: [
       /* IconButton(
          icon: Icon(Icons.local_phone, color: myColorTextIcon,),
          onPressed: () {},
        ),*/
        IconButton(
          icon: Icon(Icons.info_outline, color: HelpitalColors.myColorTextIcon,),
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(
                      child: Text(conversation.title, style: TextStyle(color: HelpitalColors.myColorTextGrey))

                  ),
                  content: SizedBox(
                    height: 400,
                    width: 300,
                    child:  ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (_) => InfoElementOfDirectory(user: user[index])
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(user[index].firstName + ' ' + user[index].lastName),
                              subtitle: Text(user[index].userRole),
                              leading: Icon(Icons.perm_identity),
                              trailing: Text(user[index].service),
                            ),
                          );
                        }),
                  )
                ));
            },
        ),
        SizedBox(width: myDefaultPadding / 2),
      ],
    );
    }

  }
}