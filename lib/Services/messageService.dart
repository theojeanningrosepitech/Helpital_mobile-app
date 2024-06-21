import 'package:helpital_mobile_app/Models/Message/message.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'dart:convert';

class MessageService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<Message>> getMessageList(idConv) async {
    try {
      final parsed = await utils.get('messages?id_conv=$idConv');
      if (parsed != null) {
        List<Message> _listConv = (parsed as List).map(
                (e) => e == null ? null : Message.fromJson(e as Map<String, dynamic>))
            ?.toList();
        print('done');
        return _listConv;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR MESSAGE GET SERVICE APP: " + e.toString());
    }
  }

  Future<bool> sendMessage(Message message) async {
    try {
      var cookie =  await authService.getCookies();
      final parsed = await utils.post('messages/message?id=${cookie.userId.toString()}&users_id=${message.receiverId.join(',').toString()}&my_id=${message.senderId}&conv_id=${message.conversationId.toString()}',
        json.encode({
          'content': message.content,
          'file': message.file.toString(),
          'file_name': message.fileName.toString(),
          'emergency_btn': message.emergency.toString(),
          'group_msg': '0',
          'content_filter': message.content
        }),
      );
      if (parsed != null) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR MESSAGE POST SERVICE APP: " + e.toString());
      return false;

    }
  }
}