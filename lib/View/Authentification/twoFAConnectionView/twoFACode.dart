import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth.dart';
import '../../../Services/stateManager.dart';

import '../../../Utils/values.dart';
import '../../../Widgets/Buttons/myButtonCustom.dart';
import '../../../Widgets/myTextFieldCustom.dart';
import 'QrCode.dart';

class TwoFACode extends StatefulWidget {
  const TwoFACode({Key key}) : super(key: key);

  @override
  _TwoFACodeState createState() => _TwoFACodeState();
}

class _TwoFACodeState extends State<TwoFACode> {
  String code;
  String errorEmail = "";
  String errorPassword = "";
  String errorG = "";
  bool isConnected = false;

  Future<void> connection(BuildContext context) async {
    AuthService().login2FA(code).then((state) {
      if (state) {
        context.read<StateManager>().connect();
        Navigator.pop(context);
      }
    });
  }

  Future<void> open2faQrCodePage(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TwoFAQrCode()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    BoxDecoration _decoration = BoxDecoration(
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
    );
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
                decoration: _decoration,
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    buildLogo(),
                    Text(
                      HelpitalStrings.VERIFICATION_CODE,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    MyTextFieldCustom(
                        name: HelpitalStrings.CODE,
                        currentInput: (_code) {
                          setState(() {
                            code = _code;
                          });
                        },
                        icon: Icons.person),
                    Text(
                      errorEmail,
                      style: TextStyle(color: Colors.red, fontSize: 14),
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
                    ),
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
    return MyButtonCustom(
        name: HelpitalStrings.CONNEXION,
        onClick: () async => await connection(context)
    );
  }

  Widget buildChooseQrCodeButton(BuildContext context) {
    return MyButtonCustom(
        name: HelpitalStrings.CHOOSE_QR_CODE_CONNECTION_METHOD,
        onClick: () async => await open2faQrCodePage(context)
    );

  }
}
