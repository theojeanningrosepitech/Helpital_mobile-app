import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Conversation/conversation.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Services/conversationService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/View/Message/createConversation.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';
import '../../Services/userService.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import 'createGroup.dart';
import 'infoElementOfConversation.dart';

class Message extends StatefulWidget {
  const Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  String name = "Messagerie";

  List<User> listUserConv;
  List<Conversation> listConv;
  Future<void> createConversation() async {
    List<User> list = await UserService().getAllUser();
    showSearch(
      context: context,
      delegate: CreateConversation(list: list),
    );
  }

  void setSearchingList(String value) {
    List<User> bufferListUser = [];
    if (value != null) {
      /*listUserConv.forEach((element) {
        if (element.firstName.toLowerCase().contains(value.toLowerCase()) || element.lastName.toLowerCase().contains(value.toLowerCase())) {
          bufferListUser.add(element);
        }
      });*/
      //listUserConv = bufferListUser;
    }
  }

  String searchString;
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onHorizontalDragUpdate: (details) {
      // Note: Sensitivity is integer used when you don't want to mess up vertical drag
      int sensitivity = 8;
      if (details.delta.dx > sensitivity) {
        Navigator.pop(context);
      }
    },
    child: Scaffold(
      appBar: buildAppBar(context),
      body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      MySearchingBar(
                        currentInput: (value) {
                          setState(() {
                            if (listUserConv != null) {
                              searchString = value;

                            }
                          });
                        },
                      ),
                      buildListOfConverstion(context),
                    ],
                  ),
                ));
          }),
    )
      );
  }
  Widget buildAppBar(BuildContext context) =>  AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
      tooltip: 'Show Snackbar',
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      name,
      style: TextStyle(
        color: HelpitalColors.black
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.add_box_outlined, color: HelpitalColors.myColorTextIcon,),
        onPressed: () async => await createConversation(),
      ),
      IconButton(
        icon: const Icon(Icons.people_alt_outlined, color: HelpitalColors.myColorTextIcon,),
        onPressed: ()  async {
         List<User> listUser = await UserService().getAllUser();
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateGroup(listUser: listUser)
          )
        );
        }
      ),

    ],
  );

  Widget buildListOfConverstion(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: FutureBuilder(
          future: ConversationService().getConversationList(),
          initialData: 0,
          builder: (context, snapshot_conv) {
    if (snapshot_conv.connectionState == ConnectionState.waiting) {
    return MyLoading();
    }
    if (snapshot_conv.hasError) {
    return MyErrorWidget();
    } else {
      listConv = snapshot_conv.data;
      //setSearchingList(searchString);
      if (listConv != null) {
        return AnimationLimiter(
            child: ListView.builder(
              itemCount: listConv.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: new Material(
                          color: Colors.transparent,
                          child: buildBlockInfoConversation(
                              context,
                              listConv[index]
                          )
                      ),
                    ),
                  ),
                );
              },
            )
        );
      } else {
        return Container(
          child: Text('pas de conversation'),
        );
      }
    }
          },
        )
    );
  }

  Widget buildBlockInfoConversation(BuildContext context,
      Conversation conv) {

    if (conv.groupConv == 0) {
      User user;
      return FutureBuilder(
          future: UserService().getUserByConv(conv),
          initialData: 0,
          builder: (context, snapshot_conv) {
            if (snapshot_conv.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot_conv.hasError) {
              return MyErrorWidget();
            } else {
              user = snapshot_conv.data;
              return InkWell(
                  onTap: () async {
                    //Conversation conv = await ConversationService().getConversation(conv.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InfoElementOfConversation(conversation: conv)));
                  },
                  child: ListTile(
                    title: Text(user.firstName + ' ' + user.lastName),
                    subtitle: Text(user.userRole),
                    leading: Icon(Icons.perm_identity),
                    trailing: Text(user.service),
                  ));
            }
          });
    } else {
      return InkWell(
          onTap: () async {
            //Conversation conv = await ConversationService().getConversation(conv.id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InfoElementOfConversation(conversation: conv)));
          },
          child: ListTile(
            title: Text(conv.title),
            leading: Icon(Icons.people_outline),


          ));
    }

}
}
