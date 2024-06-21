import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';

import '../../../../Utils/values.dart';
import '../../../Directory/infoElementOfDirectory.dart';

class BlockInfoUser extends StatelessWidget {
  User user;
  BlockInfoUser({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoElementOfDirectory(user: user))
            );
          },
          child: Container(
              width: SizeCustom().assignHeight(context: context, fraction: 0.25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: HelpitalColors.primaryGradientColors,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(15),
                        width: SizeCustom().assignHeight(context: context, fraction: 0.1),
                        height: SizeCustom().assignHeight(context: context, fraction: 0.1),
                        decoration: new BoxDecoration(
                          color: HelpitalColors.myColorTextGreyClair,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person_rounded)
                    ),
                    Text(user.firstName + ' ' + user.lastName, style: TextStyle(fontSize: SizeCustom().assignTextSize(context: context, size: 25, sizeText: (user.lastName.length + user.firstName.length + 1)), color: HelpitalColors.myColorTextGrey),),
                    Text(user.service, style: TextStyle(fontSize: SizeCustom().assignTextSize(context: context, size: 20, sizeText: (user.lastName.length + user.firstName.length + 1)), color: HelpitalColors.myColorTextGreyClair),)
                  ],
                ),
              )
          ),
        )
    );
  }
}
