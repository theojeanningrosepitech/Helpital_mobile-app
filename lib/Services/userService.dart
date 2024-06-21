import 'dart:convert' as convert;
import 'dart:convert';
import 'package:helpital_mobile_app/Models/Service/Service.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'package:http/http.dart' as http;

import '../Models/Conversation/conversation.dart';
import '../Models/User/UserRole/UserRole.dart';

class UserService {
  AuthService authService = AuthService();
  Utils utils = Utils();

  Future<List<UserRole>> getRole() async {
    try{
      final parsed = await utils.get('roles');
      if (parsed != null) {
        List<UserRole> userRole = (parsed as List).map(
                (e) => e == null ? null : UserRole.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return userRole;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROLE: " + e.toString());
    }
  }

  Future<void> getAvatar() async {
    try {
      return await utils.get('avatars');
    } catch(e) {
      print("ERROR GET ROLE: " + e.toString());
    }
  }

  Future< List<Service>> getServices() async {
    try{
      final parsed = await utils.get('services');
      if (parsed != null) {
        List<Service> services = (parsed as List).map(
                (e) => e == null ? null : Service.fromJson(e as Map<String, dynamic>))
            ?.toList();
        return services;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR GET ROLE: " + e.toString());
    }
  }

  Future<User> getUserInfo() async {

    try {
      var cookie = await AuthService().getCookies();
      final parsed = await utils.get('users?id=${cookie.userId}');
        if (parsed != null) {
          final List<UserRole> _listUserRole = await UserService().getRole();
          final List<Service> _listService = await UserService().getServices();
          User res = User.fromJson(parsed[0], _listUserRole, _listService);
          return res;
        } else {
          return null;
        }
    } catch(e) {
      print("ERROR USER APP: " + e.toString());
    }
  }
  Future<User> getUserbyId(int id) async {

    try {
      final parsed = await utils.get('users?id=$id');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        User res = User.fromJson(parsed[0], _listUserRole, _listService);
        return res;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR USER APP: " + e.toString());
    }
  }
  Future<User> getUserBylogin(String login) async {

    try {
      final parsed = await utils.get('users?contacts=true&search=$login');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        User res = User.fromJson(parsed[0], _listUserRole, _listService);

        return res;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR USER APP: " + e.toString());
    }
  }
  Future<User> getUserByConv(Conversation conv) async {

    try {
      var cookie = await AuthService().getCookies();

      int _id = (cookie.userId == conv.usersId[0]) ? conv.usersId[0] : conv.usersId[1];

      final parsed = await utils.get('users?id=$_id');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        User res = User.fromJson(parsed[0], _listUserRole, _listService);

        return res;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR USER APP: " + e.toString());
    }
  }
  Future<List<User>> getAllUser() async {
    try {
      final parsed = await utils.get('users');
      if (parsed != null) {
        final List<UserRole> _listUserRole = await UserService().getRole();
        final List<Service> _listService = await UserService().getServices();
        List<User> res = (parsed as List).map(
                (e) => e == null ? null : User.fromJson(e, _listUserRole, _listService))
            ?.toList();
        return res;
      } else {
        return null;
      }
    } catch(e) {
      print("ERROR USER APP: " + e.toString());
    }
  }


  Future<bool> modifyElem(String path, String key, String value) async {

    try {
      var cookies =  await AuthService().getCookiesJsonify();
      var cookie =  await AuthService().getCookies();
      final response = await http.put(Uri.parse('$URL/api/users/$path?id=${cookie.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
        body:  json.encode({
          key: value,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("ERROR PLANNING SERVICE APP: " + e.toString());
      return false;
    }
  }
}