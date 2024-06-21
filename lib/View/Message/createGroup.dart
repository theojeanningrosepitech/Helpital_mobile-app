import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Models/Conversation/conversation.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/User/User.dart';
import '../../Services/conversationService.dart';
import '../../Services/userService.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../Widgets/UtilsWidgets/myLoading.dart';
import '../../Widgets/mySearchingBar.dart';
import 'infoElementOfConversation.dart';

class CreateGroup extends StatefulWidget {
  List<User> listUser;

  CreateGroup({this.listUser});

  @override
  State<CreateGroup> createState() => _CreateGroupState(
    listUser: listUser
  );
}

class _CreateGroupState extends State<CreateGroup> {
  List<User> listUser;
  List<bool> listAddThisUser = [];
  String searchString;
  String title;
  _CreateGroupState({this.listUser});

  void setListAddThisUser(List<User> list) {
    list.forEach((element) {
      //print(element.firstName);
      listAddThisUser.add(false);
    });
  }
  void setSearchingList(String value) {
    List<User> bufferListUser = [];
    if (value != null) {
      listUser.forEach((element) {
        if (element.firstName.toLowerCase().contains(value.toLowerCase()) || element.lastName.toLowerCase().contains(value.toLowerCase())) {
          bufferListUser.add(element);
        }
      });
      listUser = bufferListUser;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    UserService().getAllUser().then((value) {

      listUser = value;
      setSearchingList(searchString);

    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildCore(context),
    );
  }
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: HelpitalColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: HelpitalColors.myColorTextIcon,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TextFormField(

        onChanged: (String value) {
          title = value;
        },
      ),

      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_box_outlined, color: HelpitalColors.myColorTextIcon,),
          onPressed: () async {
            Conversation conv = await ConversationService().setNewGroupConversation(listUser, listAddThisUser, title);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoElementOfConversation(conversation: conv)));

          },
        ),
      ],
    );
  }
  Widget buildCore(BuildContext context) {
    if (listAddThisUser.isEmpty) {
      setListAddThisUser(listUser);
    }
    return Container(
      child: Center(
        child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: listUser.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: new Material(
                                  color: Colors.transparent,
                                  child: buildCase(
                                      context,
                                      listUser[index],
                                    index
                                  )
                              ),
                            ),
                          ),
                        );
                      },
                    )
                )
        ),
    );
  }
  Widget buildCase(BuildContext context, User user, int index) {

    Widget dot = InkWell(
      onTap: () {
        setState(() {
          listAddThisUser[index] = !listAddThisUser[index];
        });
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: listAddThisUser[index] ? HelpitalColors.myColorTextGrey : HelpitalColors.myColorPrimary,
          shape: BoxShape.circle,
        ),
      ),
    );
    return ListTile(
      title: Text(user.firstName + ' ' + user.lastName),
      //subtitle: Text('${user.birthdate.day.toString()}/${patient.birthdate.month.toString()}/${patient.birthdate.year.toString()}'),
      trailing: dot
    );
  }
}
