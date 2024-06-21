import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth.dart';
import '../../../Services/stateManager.dart';
import '../../../Utils/values.dart';

import '../../ScanQrCode/scanQrCode.dart';

class TwoFAQrCode extends StatefulWidget {
  const TwoFAQrCode({Key key}) : super(key: key);

  @override
  _TwoFAQrCodeState createState() => _TwoFAQrCodeState();
}

class _TwoFAQrCodeState extends State<TwoFAQrCode> {
  // String code;

  Future<void> scanQrCode(BuildContext context, String code) async {
    AuthService().login2FA(code).then((state) {
      if (state) {
        context.read<StateManager>().connect();
        Navigator.pop(context);
      }
    });
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(HelpitalStrings.CONNEXION_2FA),
        backgroundColor: HelpitalColors.white,
        foregroundColor: HelpitalColors.black,
      ),
      body: Center(
        heightFactor: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height * 0.9,
                padding: EdgeInsets.all(32),
                decoration: _decoration,
                child: ScanQrCode(
                  getCode: (str) => scanQrCode(context, str),
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
