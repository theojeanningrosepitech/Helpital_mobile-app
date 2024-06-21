
part of 'conversation.dart';


Conversation _$ConversationFromJson(Map<String, dynamic> data) {
  List buffer = data['user_id'].split(',');
  List<int> fBuffer = [];
  buffer.forEach((element) {
    fBuffer.add(int.parse(element));
  });
  return Conversation(
    id: data['id'],
    usersId: fBuffer,
    title: data['title'],
    groupConv: data['group_conv'],
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) => <String, dynamic> {
  'id': instance.id,
  'user_id': instance.usersId,
  'title': instance.title,
  'group_conv': instance.groupConv,
};

