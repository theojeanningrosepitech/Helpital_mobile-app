
part of 'message.dart';


Message _$MessageFromJson(Map<String, dynamic> data) {
  List buffer = data['receiver_id'].split(',');
  List<int> fBuffer = [];
  buffer.forEach((element) {
    fBuffer.add(int.parse(element));
  });

  int _senderId = data['sender_id'];
  int _id = data['id'];
  int _conversationId = data['conversation_id'];
  String _state = data['state'];
  return Message(
    id: _id,
    conversationId: _conversationId,
    content: data['content'] == '' ? null : data['content'],
    fileName: data['file_name'] == '' ? null : data['file_name'],
    file: data['file'] == '' ? null : data['file'],
    sendAt: DateTime.parse(data['send_at']),
    senderId: _senderId,
    receiverId: (fBuffer).map(
            (e) => e == null ? null : e)
        ?.toList(),
    state: _state,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic> {
  'id': instance.id,
  'conv_id': instance.conversationId,
  'content': instance.content,
  'file_name': instance.fileName,
  'file': instance.file,
  'send_at': instance.sendAt,
  'my_id': instance.senderId,
  'users_id': instance.receiverId.join(','),
  'state': instance.state,
};

