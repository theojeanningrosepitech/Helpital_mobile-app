import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Conversation/conversation.dart';
import 'package:helpital_mobile_app/Services/messageService.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Message/message.dart';
import '../../Models/User/User.dart';
import '../../Models/Utils/Cookies.dart';
import '../../Services/auth.dart';
import '../../Widgets/UtilsWidgets/myLoading.dart';
import 'chatInput.dart';
import 'messageCard.dart';

class BodyMessage extends StatefulWidget {
  int idConv;
  Conversation conv;
  List<User> userReceiver;

  BodyMessage({this.idConv, this.userReceiver, this.conv});

  @override
  _BodyMessageState createState() =>
      _BodyMessageState(idConv: idConv, userReceiver: userReceiver, conv: conv);
}

class _BodyMessageState extends State<BodyMessage> {
  int idConv;
  Conversation conv;
  List<User> userReceiver;
  List<Message> listMessage;
  Timer timer;
  Cookies cookie;
  _BodyMessageState({this.idConv, this.userReceiver, this.conv}) {

    AuthService().getCookies().then((value) => setState(() => cookie = value));
    MessageService().getMessageList(idConv).then((value) {
      if (listMessage == null) {
        setState(() {
          listMessage = value;
        });
      } else if (listMessage.length < value.length) {

        setState(() {
          listMessage = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    /// Initialize timer for 3 seconds, it will be active as soon as intialized
      timer = Timer.periodic(new Duration(seconds: 5), (timer) {
          MessageService().getMessageList(idConv).then((value) {
          if (listMessage == null) {
            setState(() {
              listMessage = value;
            });
          } else if (listMessage.length < value.length) {
            setState(() {
              listMessage = value;
            });
          }
        });
      });

  }

  /// cancel the timer when widget is disposed,
  /// to avoid any active timer that is not executed yet
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
  List<ChatMessage> listChatMessage;

  void setListMessage(List<Message> listMessage) {
    listChatMessage = [];

    listMessage.forEach((element) async {
      ChatMessageType chatMessageType;
      if (element.file != null && element.file != '' && element.content != null && element.content != '') {
        chatMessageType = ChatMessageType.both;
      } else if (element.content != null && element.content != '') {
        chatMessageType = ChatMessageType.text;
      } else if (element.file != null && element.file != '') {
        chatMessageType = ChatMessageType.image;
      }
      print('testtttttt === ');
      for (int i = 0 ; i < userReceiver.length; i++) {
          if (element.senderId != userReceiver[i].id) {
          listChatMessage.add(
            ChatMessage(
              text: element.content != null ? element.content : '',
              file: element.file != null ? element.file : '',
              messageType: chatMessageType,
              messageStatus: MessageStatus.viewed,
              isSender: false,
                senderId: element.senderId
            ),
          );
          break;
        } else {
          listChatMessage.add(
            ChatMessage(
              text: element.content != null ? element.content : '',
              file: element.file != null ? element.file : '',
              messageType: chatMessageType,
              messageStatus: MessageStatus.viewed,
              isSender: true,
                senderId: element.senderId


            ),
          );

            break;
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    if (cookie != null && listMessage != null) {
      setListMessage(listMessage);
      if (listChatMessage != null) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: myDefaultPadding),
                  child: listChatMessage.length != 0
                      ? ListView.builder(
                      itemCount: listChatMessage.length,
                          itemBuilder: (context, index) {
                            userReceiver.forEach((element) {
                              print(element.firstName);
                              if (element.id == listChatMessage[index].senderId) {
                                listChatMessage[index].setSender(element);
                              }
                            });
                            return MessageCard(message: listChatMessage[index]);
                      })
                      : Container(
                          child: Center(
                            child: Text('pas de message'),
                          ),
                        )
                  /*StreamBuilder(
                    stream: ,
                    builder: (context, snapshot)  {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyLoading();
                      }
                      if (snapshot.hasError) {
                        return Text("Error");
                      } else {
                        if (snapshot.data != null) {
                          return ;

                        } else {
                          return Container(
                            child: Center(
                              child: Text('pas de message'),
                            ),
                          );
                        }
                        }
                    }

                )*/
                  ),
            ),
            ChatInputField(currentInput: (content) {

              Message _msg = Message(
                  id: 0,
                  conversationId: idConv,
                  content: content,
                  fileName: '',
                  file: '',
                  emergency: 0,
                  sendAt: null,
                  senderId: int.parse(cookie.userId),
                  receiverId: conv.usersId,
                  state: 'null');
              MessageService().sendMessage(_msg);
              setState(() {});
            }),
          ],
        );
      } else {
        return MyLoading();
      }
    } else {
      return MyLoading();
    }
  }
}
