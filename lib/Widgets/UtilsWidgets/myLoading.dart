import 'package:flutter/cupertino.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Image.asset(
          HelpitalAssets.HELPITAL_LOADING_GIF,
          height: 125.0,
          width: 125.0,
        ),

      ),
    );
  }
}
