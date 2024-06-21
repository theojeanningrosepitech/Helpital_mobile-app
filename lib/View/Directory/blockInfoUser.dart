import 'package:flutter/material.dart';

import '../../Models/Conversation/conversation.dart';
import '../../Models/User/User.dart';
import '../../../../Utils/values.dart';

import '../../Services/conversationService.dart';
import '../../Widgets/Buttons/myButtonContact.dart';
import '../../Widgets/UtilsWidgets/myRouteBuilder.dart';
import '../Message/infoElementOfConversation.dart';
import 'infoElementOfDirectory.dart';

class BlockInfoUser extends StatelessWidget {
  User user;
  BlockInfoUser({Key key, this.user}) : super(key: key);

  var size;
  String name;
  String email;
  String number;
  String profession;
  double _width;
  double _height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    name = user.firstName + ' ' + user.lastName;
    email = user.email;
    number = user.phone;
    profession = user.userRole;
    _width = size.width;
    _height = size.height * 0.12;

    BoxDecoration _decoration = BoxDecoration(
      color: HelpitalColors.white,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(myDefaultBorderRadius),
        topLeft: Radius.circular(myDefaultBorderRadius),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: HelpitalColors.black,
          offset: Offset(0.0, 1.0),
          blurRadius: 1,
        ),
      ],
    );
    EdgeInsets _margin = EdgeInsets.only(
      left: 20,
      right: 20,
      top: 10,
    );
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoElementOfDirectory(user: user))
          );
        },
        child: Container(
            margin: _margin,
            width: _width,
            height: _height,
            decoration: _decoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: buildTopPart(),
                ),
                Expanded(
                    flex: 3,
                    child: buildBottomPart(context)
                ),
                SizedBox(height: 10,)
              ],
            )
        )
    );
  }

  Widget buildTopPart() {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: HelpitalColors.myColorFourth,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(myDefaultBorderRadius),
                )
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: _width * 0.2,
              height: _height * 0.3,
              decoration: BoxDecoration(
                color: HelpitalColors.myColorThird,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(myDefaultBorderRadius),
                    bottomRight: Radius.circular(myDefaultBorderRadius)),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(profession ?? '',
                    style: TextStyle(
                        color: HelpitalColors.myColorTextGreyClair
                    )
                ),
              ),
            ),
          ),
          Container(
            color: HelpitalColors.myColorPrimary,
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0
              ),
              width: _width * 0.4,
              height: _height * 0.3,
              decoration: BoxDecoration(
                color: HelpitalColors.myColorFourth,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(myDefaultBorderRadius)
                ),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(email ?? '',
                    style: TextStyle(
                        color: HelpitalColors.myColorTextGreyClair
                    )
                ),
              ),
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: _width * 0.2,
              height: _height * 0.3,
              decoration: BoxDecoration(
                color: HelpitalColors.myColorPrimary,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(myDefaultBorderRadius)),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(number,
                    style: TextStyle(
                        color: HelpitalColors.myColorTextGreyClair)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomPart(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: FittedBox(
              fit: BoxFit.contain,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(name ?? '',
                    style: TextStyle(
                        color: HelpitalColors.myColorTextIcon)
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container()
          ),
          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    MyButtonContact(
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
                    ),
                  ],
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: Container()
          ),
        ],
      ),
    );
  }
}
