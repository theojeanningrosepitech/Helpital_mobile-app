import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MySearchingBar extends StatelessWidget {

  final Function(String) currentInput;
  MySearchingBar({
    @required this.currentInput,

  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var borderRadius = 30.0;

    return Container(
      padding: EdgeInsets.all(10.0),
      height: 70,
      child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: HelpitalColors.white,
              /*boxShadow: <BoxShadow>[
                BoxShadow(
                  color: HelpitalColors.black,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1,
                ),
              ],*/
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
            child: TextFormField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              enableSuggestions: true,

              cursorColor: Colors.black26,
              style: TextStyle(color: Colors.black45),
              decoration: InputDecoration(
                hintText: 'Recherche',
                hintStyle: TextStyle(color: Colors.black38),
                filled: true,
                fillColor: Colors.black12,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HelpitalColors.white),
                    borderRadius: BorderRadius.circular(borderRadius)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              onTap: () {
                print("I'm here!!!");
              },
              onChanged: (str) {
                this.currentInput(str);
              },
            ),
          )),
    );
  }
}
