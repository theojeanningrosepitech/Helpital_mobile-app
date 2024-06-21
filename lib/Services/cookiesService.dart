import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Utils/ConnectionParameters.dart';
import '../Models/Utils/Cookies.dart';
import '../Utils/values.dart';

class CookiesService {

  Future<SharedPreferences> get prefs async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future setToken(token, userId, machineId) async {
    SharedPreferences _prefs = await prefs;
    _prefs.setString('token', token);
    _prefs.setString('userId', userId.toString());
    _prefs.setString('machineId', machineId.toString());
  }
  void setFavorisList() async{
    SharedPreferences _prefs = await prefs;

    List<String> list = _prefs.getStringList('listFavoris');
    if (list == null) {
      _prefs.setStringList('listFavoris', listPage);
    }
  }
  Future<bool> initNewFavorisList(List<String> newList) async{
    SharedPreferences _prefs = await prefs;

    _prefs.remove('listFavoris');

    List<String> list = _prefs.getStringList('listFavoris');
    if (list == null) {
      _prefs.setStringList('listFavoris', newList);
      return true;
    }
    return false;
  }

  Future<List<String>> getFavorisList() async{
    SharedPreferences _prefs = await prefs;
    await setFavorisList();
    List<String> res = _prefs.getStringList('listFavoris');
    return res;
  }

  Future setConnectionParameters(ConnectionParameters param) async {
    SharedPreferences _prefs = await prefs;
    _prefs.setString('typeConnection', param.typeConnection.index.toString());
    _prefs.setString('typePreferedSendingMethod', param.typePreferedSendingMethod.index.toString());
    _prefs.setString('token', param.token.toString());
  }

  Future<ConnectionParameters> getConnectionParameters() async {
    SharedPreferences _prefs = await prefs;
    try {
      ConnectionParameters connectionParameters = ConnectionParameters(
          token: _prefs.get('token'),
          typeConnection: TypeConnection.values[int.parse(_prefs.get('typeConnection'))],
          typePreferedSendingMethod: TypePreferedSendingMethod.values[int.parse(_prefs.get('typePreferedSendingMethod'))]
      );
      return connectionParameters;
    } catch(e) {
      print('ERROR: ' + e);
      return null;
    }
  }

  Future cleanLocalStorageAndSetCookie(sessionID, userId, machineId) async {
    SharedPreferences _prefs = await prefs;
    _prefs.remove('typeConnection');
    _prefs.remove('typePreferedSendingMethod');
    _prefs.remove('token');
    _prefs.setString('userId', userId.toString());
    _prefs.setString('machineId', machineId.toString());
    _prefs.setString('token', sessionID.toString());
  }

  Future removeCookies() async {
    SharedPreferences _prefs = await prefs;

    _prefs.remove('machineId');
    _prefs.remove('userId');
    _prefs.remove('token');
  }

  Future<String> getCookiesJsonify() async {
    final cookies = await getCookies();
    return json.encode({
      'machine_id': cookies.machineId,
      'sessionID': cookies.sessionId,
      'userId': cookies.userId,
    });
  }

  Future<Cookies> getCookies() async {
    SharedPreferences _prefs = await prefs;
    try {
      Cookies cookies = Cookies(
          userId: _prefs.get('userId'),
          sessionId: _prefs.get('token'),
          machineId: _prefs.get('machineId')
      );
      return cookies;

    } catch(e) {
      return null;
    }
  }

  Future removeToken() async {
    SharedPreferences _prefs = await prefs;
    _prefs.remove('apiToken');
  }

  void getCurrentUser() async {
    print("get user");
  }

  Cookies getCookiesFromApi(String query) {
    final sessionIdQuery = query.split(';')[0];
    final userIdQuery = query.split(';')[1];

    final sessionId = sessionIdQuery.split('=')[1];
    final userId = userIdQuery.split(',')[1].split('=')[1];

    return Cookies(userId: userId, sessionId: sessionId);
  }
}