import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/auth.dart';
import 'package:helpital_mobile_app/Services/stateManagerConnection.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';
import 'package:provider/provider.dart';

import '../../Models/Utils/ConnectionParameters.dart';
import '../../Services/stateManager.dart';

class Login extends StatefulWidget {
    @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;
  String errorEmail = "";
  String errorPassword = "";
  String errorG = "";
  bool isConnected = false;


  void connection() async {
    if (password != null && password.length < 6) {
      setState(() {
        password = null;
        errorPassword = HelpitalStrings.ERROR_PASSWORD;
      });
    }
    if (username != null && password != null) {
      username = username.split(" ").join("");

      AuthService().login(username, password).then((ConnectionParameters parameters) {
        if(parameters.typeConnection == TypeConnection.Normal) {
          context.read<StateManager>().connect();
        } else if (parameters.typeConnection == TypeConnection.TwoFA) {
          print('ca rentre dans le fichier login 2FA');
          context.read<StateManagerConnection>().setParameters(parameters);
          context.read<StateManagerConnection>().firstStepValidate();
        } else if (parameters.typeConnection == TypeConnection.ErrorConnection) {
          setState(() {
            errorG = HelpitalStrings.ERROR_INVALID_ENTRIES;
          });
        }
      });


    } else {
      setState(() {
        errorG = HelpitalStrings.ERROR_INVALID_ENTRIES;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      body: Center(
        heightFactor: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: size.height,
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: HelpitalColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    buildLogo(),
                    Text(
                      HelpitalStrings.CONNEXION,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    MyTextFieldCustom(
                        name: HelpitalStrings.USER_NAME,
                        currentInput: (_username) {
                          setState(() {
                            username = _username;
                          });
                        },
                        icon: Icons.person),
                    Text(
                      errorEmail,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    MyTextFieldCustom(
                        name: HelpitalStrings.PASSWORD,
                        currentInput: (_password) {
                          setState(() {
                            password = _password;
                          });
                        },
                        textObscure: true,
                        icon: Icons.lock
                    ),
                Center(
                  child: Text(
                      errorPassword,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),),
                    Center(
                      child:
                    Text(
                      errorG,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 150),
              buildLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      HelpitalAssets.HELPITAL,
      scale: 5,
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
    child: MyButtonCustom(
        name: HelpitalStrings.CONNEXION,
        onClick: () async => connection()),
    );

  }
}
