
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class MySelectorFilter extends StatelessWidget {
  String name;
  bool isSelected;
  int index;
  Color _color = HelpitalColors.white;
  final VoidCallback boxSelected;
  MySelectorFilter({this.name, this.isSelected, this.index, this.boxSelected});

  @override
  Widget build(BuildContext context) {
    if (this.isSelected) {
      _color = HelpitalColors.green;
    }

    return
      FittedBox(
        fit: BoxFit.contain,
        child:Container(
      padding: EdgeInsets.all(5),
      child:  Row(

          children: [
            InkWell(
              onTap: boxSelected,
              child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: HelpitalColors.myColorTextGrey,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: buildBox(_color)
              ),
            ),
            SizedBox(width: 5,),
            Container(
              child: Text(name, style: TextStyle(color: HelpitalColors.myColorTextIcon),),

      )
          ],
        ),

    ));
  }
  Widget buildBox(color) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(2),

    );
  }
}