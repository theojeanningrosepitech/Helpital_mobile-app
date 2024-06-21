import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'message.g.dart';

enum ChatMessageType { text, image, both }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final String file;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  int senderId;
  User sender;
  ChatMessage({
    this.text = '',
    this.file = '',
    @required this.messageType,
    @required this.messageStatus,
    @required this.isSender,
    this.senderId,
    this.sender
  });

  void setSender(User _user) {
    sender = _user;
  }
}

@JsonSerializable()
class Message {
  int id;
  int conversationId;
  String content;
  String fileName;
  String file;
  int emergency;
  DateTime sendAt;
  int senderId;
  List<int> receiverId;
  String state;

  Message({
    this.id,
    this.conversationId,
    this.content,
    this.fileName,
    this.file,
    this.emergency,
    this.sendAt,
    this.senderId,
    this.receiverId,
    this.state,
  });
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson(Message message) => _$MessageToJson(message);
}