import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:helpital_mobile_app/Utils/values.dart';


class ScanQrCode extends StatefulWidget {
  Function(String) getCode;
  ScanQrCode({Key key, this.getCode}) : super(key: key);

  @override
  _ScanQrCodeState createState() => _ScanQrCodeState(getCode: getCode);
}

class _ScanQrCodeState extends State<ScanQrCode> {
  Barcode result;
  Function(String) getCode;

  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _ScanQrCodeState({this.getCode});
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        getCode(result.code);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}