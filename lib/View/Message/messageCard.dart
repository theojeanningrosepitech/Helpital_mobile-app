import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Message/fileMessage.dart';

import '../../Models/Message/message.dart';
import '../../Models/User/User.dart';
import 'fileAndTextMessage.dart';
import 'textMessage.dart';

class MessageCard extends StatelessWidget {
  MessageCard({
    Key key,
    @required this.message,
    this.user

  }) : super(key: key);

  final ChatMessage message;
  User user;

  @override
  Widget build(BuildContext context) {

    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.image:
          return FileMessage(message: message);
        case ChatMessageType.both:
          return FileAndTextMessage(message: message);
        //case ChatMessageType.video:
          //return VideoMessage();
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: myDefaultPadding),
      child: Row(
        mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            children: [
              if (!message.isSender) ...[
                Text(message.sender.firstName),
                //SizedBox(width: myDefaultPadding / 2),
              ],
              messageContaint(message),
            ],
          )
          //if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return HelpitalColors.red;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
        case MessageStatus.viewed:
          return HelpitalColors.myColorPrimary;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: myDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,/*    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: assignHeight(context: context, fraction: 0.05),
        width: double.infinity,
        color: MyColors.green,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          color: MyColors.green,
          child: BoxCont
        )
    );*/
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}