
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MyButtonContact extends StatelessWidget {
  Icon icon;
  Color color;
  final VoidCallback onClick;

  MyButtonContact({
    this.icon,
    this.color,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onClick,
      child: Container(
          decoration: BoxDecoration(
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: HelpitalColors.black,
                offset: Offset(0.0, 1.0),
                blurRadius: 1,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(myDefaultBorderRadius),
              topLeft: Radius.circular(myDefaultBorderRadius),
              bottomLeft: Radius.circular(myDefaultBorderRadius),
              bottomRight: Radius.circular(myDefaultBorderRadius),
            ),
          ),
          padding: EdgeInsets.all(5),
          height: 37,
          width: 35,
          child: FittedBox(
            fit: BoxFit.contain,
            child: icon,
          )
      ),
    );
  }
}
