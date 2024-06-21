import 'package:json_annotation/json_annotation.dart';


part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  int id;
  List<int> usersId;
  String title;
  int groupConv;


  Conversation({
    this.id,
    this.usersId,
    this.title,
    this.groupConv
  });
  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson(Conversation conversation) => _$ConversationToJson(conversation);
}