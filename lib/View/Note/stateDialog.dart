
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';


class StateDialog extends StatelessWidget {

  String title;
  String content;
  Color color;
  StateDialog({this.title, this.content, this.color});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: Center(
        child: Column(
          children: [
          Text(title, style: TextStyle(color: color)),
            SizedBox(height: 5,),
            Center(
                child:
          Text(content, style: TextStyle(fontSize: 10),))
          ],
        )

      ),


    );

  }


}