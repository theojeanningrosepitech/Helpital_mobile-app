import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MyTextFieldCustom extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function(String) currentInput;
  bool textObscure;
  bool canEdit;
  TextEditingController controller;
  MyTextFieldCustom({
    @required this.name,
    @required this.currentInput,
    @required this.icon,
    this.textObscure = false,
    this.canEdit = true,
    this.controller
  });



  @override
  Widget build(BuildContext context) {
    double around = 30;

    InputDecoration _decoration = InputDecoration(
      disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      hintText: name,
      hintStyle: TextStyle(color: Colors.black38),
      filled: false,
      fillColor: HelpitalColors.myColorTextGreyClair,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HelpitalColors.white),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(around),
          bottomRight: Radius.circular(around),

        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),

        borderRadius: BorderRadius.only(

          topRight: Radius.circular(around),
          bottomRight: Radius.circular(around),

        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(around),
          bottomRight: Radius.circular(around),

        ),
      ),
    );
    if (_decoration != null) {

    return Container(
      decoration: BoxDecoration(
        color: HelpitalColors.myColorTextGreyClair,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(around),
            topRight: Radius.circular(around),
            bottomLeft: Radius.circular(around),
            bottomRight: Radius.circular(around)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
              child: Container(

            child: Icon(this.icon, color: HelpitalColors.myColorPrimary,),
          ),
          ),
          Expanded(
              flex: 8,
              child: Container(
            child: TextFormField(
              controller: this.controller,
              enabled:  this.canEdit,
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: HelpitalColors.white,
              style: TextStyle(color: Colors.black45),
              decoration: _decoration,
              obscureText: this.textObscure ? this.textObscure : false,

              onSaved: (username) {
                currentInput(username);
              },
              onChanged: (username) {
              currentInput(username);
            },
            ),
          )
          )
        ],
      ),
    );
    }

  }
}



