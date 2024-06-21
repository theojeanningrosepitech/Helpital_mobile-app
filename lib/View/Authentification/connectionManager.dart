import 'package:flutter/cupertino.dart';
import 'package:helpital_mobile_app/Services/stateManagerConnection.dart';
import 'package:helpital_mobile_app/View/Authentification/validateConnection.dart';
import 'package:helpital_mobile_app/View/Login/login.dart';
import 'package:provider/provider.dart';

class ConnectionManager extends StatelessWidget {
  const ConnectionManager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool state = context.watch<StateManagerConnection>().state;

    if (state) {
      return ValidateConnection();
    } else {
      return Login();
    }
  }
}
