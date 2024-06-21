import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Message/message.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: SizeCustom().assignWidth(context: context, fraction: 0.83),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: HelpitalColors.myColorFourth,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 10,
        softWrap: false,
      ),
    );
  }
}