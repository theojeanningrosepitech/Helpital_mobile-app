import 'package:flutter/cupertino.dart';
import 'package:helpital_mobile_app/View/Authentification/twoFAConnectionView/Choose2FAMethod.dart';
import 'package:provider/provider.dart';

import '../../Models/Utils/ConnectionParameters.dart';
import '../../Services/stateManagerConnection.dart';

class ValidateConnection extends StatefulWidget {
  const ValidateConnection({Key key}) : super(key: key);

  @override
  _ValidateConnectionState createState() => _ValidateConnectionState();
}

class _ValidateConnectionState extends State<ValidateConnection> {
  @override
  Widget build(BuildContext context) {
    final TypePreferedSendingMethod typePreferedSendingMethod = context.watch<StateManagerConnection>().typePreferedSendingMethod;

    if (typePreferedSendingMethod == TypePreferedSendingMethod.Email) {
      return Choose2FAMethod();
    } else {
      return Container();
    }

  }
}
