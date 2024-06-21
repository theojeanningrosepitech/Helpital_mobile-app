import 'package:helpital_mobile_app/Models/Conversation/conversation.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/Utils/Cookies.dart';

class ConversationService {
  AuthService authService = AuthService();
  Utils utils = Utils();
  String pathConvertsation = 'conversations';
  Future<List<Conversation>> getConversationList() async {
      try {
        Cookies cookie =  await authService.getCookies();
        final parsed = await utils.get('$pathConvertsation?id=${cookie.userId}');
        if (parsed != null) {
          List<Conversation> _listConv = (parsed as List).map(
                  (e) => e == null ? null : Conversation.fromJson(e as Map<String, dynamic>))
              ?.toList();
          return _listConv;
        } else {
          return null;
        }
      } catch(e) {
        print("ERROR GET CONVERSATION LIST SERVICE APP: " + e.toString());
      }
    }

  Future<List<User>> getUserConversationList(List<Conversation> listconv) async {
    try {
      List<User> listUserResult = [];
      var cookie =  await authService.getCookies();
      //List<Conversation> listconv = await ConversationService().getConversationList();
      List<User> listUser = await UserService().getAllUser();
      if (listUser != null && listconv.isNotEmpty) {
        listconv.forEach((conv) {
            int _id = (cookie.userId == conv.usersId[0]) ? conv.usersId[0] : conv.usersId[1];
              listUser.forEach((user) {
            if (_id == user.id) {

                listUserResult.add(user);
            }
              });
        });
        return listUserResult;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET USER CONVERSATION LIST SERVICE APP: " + e.toString());
    }
  }

  Future<List<User>> getUserFromOneConversationList(Conversation conv) async {
    try {
      List<User> listUserResult = [];
      //List<Conversation> listconv = await ConversationService().getConversationList();
      List<User> listUser = await UserService().getAllUser();
      if (listUser != null) {
          conv.usersId.forEach((_id) {
            listUser.forEach((user) {
              if (_id == user.id) {
                listUserResult.add(user);
              }
            });
          });
        return listUserResult;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET USER FROM CONVERSATION LIST SERVICE APP: " + e.toString());
    }
  }
  Future<Conversation> getConversation(idConv) async {
    try {
      var cookie =  await authService.getCookies();
      final parsed = await utils.get('$pathConvertsation?id_conv=$idConv');
      if (parsed != null) {
        Conversation _conv = Conversation.fromJson(parsed[0]);
        return _conv;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET CONVERSATION SERVICE APP: " + e.toString());
    }
  }

  Future<Conversation> setNewConversation(User SecondUser) async {
    try {
      var cookie =  await authService.getCookies();
      var cookies =  await AuthService().getCookiesJsonify();

      var result = http.post(Uri.parse('$URL/api/$pathConvertsation/conversation'),
          headers: {
            'Content-Type': 'application/json',
            'cookie': cookies
          },
          body:  json.encode({
            'user_id': cookie.userId.toString() + ',' + SecondUser.id.toString(),
            'title': 'Conversation',
            'group_conv': "0"
          })
      );

      return result.then((value) async {
        final parsed = json.decode(value.body).cast<String, dynamic>();
        if (value.statusCode == 201) {
          Conversation conv = await getConversation(parsed['id'].toString());
            return conv;
        }
        return null;
      });

    } catch(e) {
      print("ERROR SET CONVERSATION SERVICE APP: " + e.toString());
    }
  }
  Future<Conversation> setNewGroupConversation(List<User> listuser, List<bool> listAddThisUser, String title) async {
    List idUser = [];
    for (int i = 0; i < listuser.length; i++) {
      if (listAddThisUser[i]) {
        idUser.add(listuser[i].id);
      }
    }

    try {
      var cookie =  await authService.getCookies();
      var cookies =  await AuthService().getCookiesJsonify();


      var result = http.post(Uri.parse('$URL/api/$pathConvertsation/conversation'),
          headers: {
            'Content-Type': 'application/json',
            'cookie': cookies
          },
          body:  json.encode({
            'user_id': cookie.userId+','+idUser.join(','),
            'title': title,
            'group_conv': "1"
          })
      );
      return result.then((value) async {
        final parsed = json.decode(value.body).cast<String, dynamic>();
        if (value.statusCode == 201) {
          Conversation conv = await getConversation(parsed['id'].toString());
          return conv;
        }
        return null;
      });
    } catch(e) {
      print("ERROR SET CONVERSATION SERVICE APP: " + e.toString());
    }
  }

}