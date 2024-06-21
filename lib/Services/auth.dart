import 'dart:convert';
import 'package:helpital_mobile_app/Services/cookiesService.dart';
import 'package:helpital_mobile_app/Services/utils.dart';
import 'package:http/http.dart' as http;

import '../Models/Utils/ConnectionParameters.dart';
import '../Models/Utils/Cookies.dart';


/// To Modify when you use the local server

class AuthService extends CookiesService {

  Future<ConnectionParameters> login(String email, String password) async {
    try {
      int machineId = 1;
      return http.post(Uri.parse('$URL/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': 'machine_id=0'
        },
        body: json.encode({
          'device_type': 1,
          'login': email,
          'password': password,
          'machineId': machineId.toString(),
        }),
      ).then((value) {
        final parsed = json.decode(value.body).cast<String, dynamic>();
        if (parsed['type'] == 'simple') {
            final cookiesQuery = value.headers['set-cookie'];
            if (cookiesQuery.isNotEmpty) {
              Cookies cookies = getCookiesFromApi(cookiesQuery);
              setToken(cookies.sessionId, cookies.userId, machineId);
              ConnectionParameters connectionParam = ConnectionParameters(
                  typeConnection: TypeConnection.Normal,
                  typePreferedSendingMethod: TypePreferedSendingMethod.No2FA,
                  token: parsed['token']
              );
              return connectionParam;
            }
        } else if (parsed['type'] == '2FA') {
          if (parsed['prefered_sending_method'] == 'email') {
            ConnectionParameters connectionParam = ConnectionParameters(
                  typeConnection: TypeConnection.TwoFA,
                  typePreferedSendingMethod: TypePreferedSendingMethod.Email,
                  token: parsed['token']
              );
              setConnectionParameters(connectionParam);
              return connectionParam;
          } else {
            return ConnectionParameters(
                typeConnection: TypeConnection.ErrorConnection,
                typePreferedSendingMethod: TypePreferedSendingMethod.ErrorConnection,
                token: ''
            );
          }
        }
        return ConnectionParameters(
            typeConnection: TypeConnection.ErrorConnection,
            typePreferedSendingMethod: TypePreferedSendingMethod.ErrorConnection
        );
      });
    } catch(e) {
      print("ERROR APP: " + e.toString());
      return ConnectionParameters(
          typeConnection: TypeConnection.ErrorConnection,
          typePreferedSendingMethod: TypePreferedSendingMethod.ErrorConnection
      );
    }
  }


  ///2fa/login
  Future<bool> login2FA(String code) async {
    try {
      int machineId = 1;
      String method;
      final ConnectionParameters param = await CookiesService().getConnectionParameters();
      if (param.typePreferedSendingMethod == TypePreferedSendingMethod.Email) {
        method = 'email';
      }
      final response = http.post(Uri.parse('$URL/api/auth/2fa/login'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': 'token-2FA=${param.token}'
        },
        body: json.encode({
          'device_type': 1,
          'code': code,
          'method': method,
          'machineId': machineId.toString(),
        }),
      );
      return response.then((value) {
        final parsed = json.decode(value.body).cast<String, dynamic>();
        if (value.statusCode == 200) {
          cleanLocalStorageAndSetCookie(parsed['sessionID'], parsed['userId'], machineId);
          return true;
        }
        return false;
      });
    } catch(e) {
      print("ERROR APP: " + e.toString());
      return false;
    }
  }

  void send2FACode(String sendingMethod) async {
    final ConnectionParameters param = await CookiesService().getConnectionParameters();
    try {
      final response = http.get(Uri.parse('$URL/api/auth/2fa/send?method=$sendingMethod'),
        headers: {
          'cookie': 'token-2FA=${param.token}'
        }
      );
      response.then((value) {
        if (value.statusCode == 200) {
          print("2FA code sent");
        }
      });
    } catch(e) {
      print("ERROR APP: " + e.toString());
    }
  }

  //sign out
  Future logout() async {
    try {
      var cookies =  await AuthService().getCookiesJsonify();
      final response = http.get(Uri.parse('$URL/api/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookies
        },
      );
      response.then((value) {
        removeCookies();
      });
    } catch(e) {
      print("ERROR APP: " + e.toString());
    }
  }
}
