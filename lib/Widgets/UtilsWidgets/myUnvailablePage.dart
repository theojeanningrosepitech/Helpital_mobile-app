import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MyUnvailablePage extends StatelessWidget {
  const MyUnvailablePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HelpitalColors.myColorBackground,
      body: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1,),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
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
                    Text(HelpitalStrings.SORRY + '....', style: TextStyle(fontSize: 30),),
                    SizedBox(height: 20,),
                    RichText( text:
                    TextSpan(
                      text: HelpitalStrings.ERROR_PAGE_SENTENCE,
                      style: TextStyle(color: HelpitalColors.black)
                    )
                    )
                  ],
                ),
              ),
              Image.asset(
                HelpitalAssets.ROBOT_GIF,
                height: 300.0,
                width: 300.0,

              ),
            ],
          )
      ),
    );
  }
}
