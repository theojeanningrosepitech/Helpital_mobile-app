import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MyButtonCustom extends StatefulWidget {
  final String name;
  final VoidCallback onClick;

  MyButtonCustom({
    @required this.name,
    @required this.onClick,
  });

  @protected
  _MyButtonCustomState createState() => _MyButtonCustomState(
    name: this.name,
    onClick: this.onClick,
  );
}

class _MyButtonCustomState extends State<MyButtonCustom> {

  final String name;
  final VoidCallback onClick;

  double sizeBar = 70;
  bool barIsOpen = false;

  _MyButtonCustomState({
    @required this.name,
    @required this.onClick,
  });

  Widget build(BuildContext context) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.fromHeight(50),
        backgroundColor: HelpitalColors.myColorPrimary,
        primary: HelpitalColors.myColorBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(fontSize: 16, color: HelpitalColors.white),
      ),
      onPressed: () => this.onClick(),

    );
  }
}

