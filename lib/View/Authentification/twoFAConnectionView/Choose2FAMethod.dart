import 'package:flutter/material.dart';

import '../../../Services/auth.dart';
import '../../../Utils/values.dart';

import '../../../Widgets/Buttons/myButtonCustom.dart';
import 'QrCode.dart';
import 'twoFACode.dart';

class Choose2FAMethod extends StatefulWidget {
  const Choose2FAMethod({Key key}) : super(key: key);

  @override
  _Choose2FAMethodState createState() => _Choose2FAMethodState();
}

class _Choose2FAMethodState extends State<Choose2FAMethod> {
  String code;
  String errorEmail = "";
  String errorPassword = "";
  String errorG = "";
  bool isConnected = false;

  Future<void> open2faEmailPage(BuildContext context) async {
    AuthService().send2FACode('email');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TwoFACode()));
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
                    SizedBox(height: 16),
                    Text(
                      HelpitalStrings.CHOOSE_2FA_METHOD,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    MyButtonCustom(
                        name: HelpitalStrings.CHOOSE_EMAIL_CONNECTION_METHOD,
                        onClick: () async => await open2faEmailPage(context)
                    ),
                    SizedBox(height: 16),
                    MyButtonCustom(
                        name: HelpitalStrings.CHOOSE_QR_CODE_CONNECTION_METHOD,
                        onClick: () async => await open2faQrCodePage(context)
                    )
                  ],
                ),
              ),
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
}
