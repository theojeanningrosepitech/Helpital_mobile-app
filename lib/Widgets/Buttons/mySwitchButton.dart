import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MySwitchButton extends StatefulWidget {
  bool apply;
  Function(bool) onClick;

  MySwitchButton({
    this.apply,
    this.onClick

  });
  @override
  _MySwitchButtonState createState() => _MySwitchButtonState(
    apply: this.apply,
    onClick: this.onClick
  );
}

class _MySwitchButtonState extends State<MySwitchButton> {

  bool apply;
  final Function(bool) onClick;

  _MySwitchButtonState({
    this.apply,
    this.onClick

});

  Alignment align;
  double posH;
  double posW;
  Color colorBackGround;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (apply) {
      align = Alignment.topLeft;
      colorBackGround = HelpitalColors.green;
    }
    else {
      align = Alignment.topRight;
      colorBackGround = HelpitalColors.myColorTextGrey;

    }

    return InkWell(
      onTap: () {
        setState(() {
          apply = !apply;
          this.onClick(apply);

        });
      },
      child: Container(
        padding: EdgeInsets.all(1),
        width: size.width* 0.12,
        decoration: BoxDecoration(
          color: colorBackGround,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: AnimatedContainer(

          duration: const Duration(milliseconds: 375),

          alignment: align,
          child: Container(
            width: 20,
            height: 20,
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
          ),

        ),
      ),
    );
  }


}
