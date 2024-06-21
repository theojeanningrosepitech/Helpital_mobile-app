import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({Key key, this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HelpitalColors.myColorPrimary,
        title: Text(url.split('/').last),
      ),
      body: Center(
        child:  Image.network(url),
      )
    );
  }
}
