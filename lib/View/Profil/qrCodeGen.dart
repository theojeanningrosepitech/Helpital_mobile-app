import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGen extends StatefulWidget {
  var data;
  String title;
  QrCodeGen({Key key, this.data, this.title}) : super(key: key);

  @override
  _QrCodeGenState createState() => _QrCodeGenState();
}

class _QrCodeGenState extends State<QrCodeGen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: HelpitalColors.myColorTextIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: HelpitalColors.white,
        title: Text('Qr Code de ${widget.title}', style: TextStyle(color: HelpitalColors.myColorTextIcon),),
      ),
      body: Center(
        child: QrImage(
          data: widget.data,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
