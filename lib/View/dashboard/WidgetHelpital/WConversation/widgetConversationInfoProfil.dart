import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:helpital_mobile_app/Services/conversationService.dart';
import 'package:helpital_mobile_app/View/dashboard/WidgetHelpital/WConversation/blockInfoUserWidget.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';

import '../../../../Models/User/User.dart';
import '../../../../Utils/values.dart';


class WidgetConversationInfoProfil extends StatefulWidget {
  const WidgetConversationInfoProfil({Key key}) : super(key: key);

  @override
  _WidgetConversationInfoProfilState createState() => _WidgetConversationInfoProfilState();
}

class _WidgetConversationInfoProfilState extends State<WidgetConversationInfoProfil> {
  List<User> listUser;
  _WidgetConversationInfoProfilState() {
    ConversationService().getConversationList().then((value) {

    ConversationService().getUserConversationList(value).then((value) {
      setState(() {
        listUser = value;
      });
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeCustom().assignHeight(context: context, fraction: 0.3),
        width: SizeCustom().assignWidth(context: context, fraction: 1),
        child: buildBottom(context)
    );
  }
  Widget buildBottom(BuildContext context) {
    return listUser != null ? LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(

              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: viewportConstraints.maxWidth
                ),
                child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listUser.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: new Material(
                                  color: Colors.transparent,
                                  child: BlockInfoUser(user: listUser[index])
                              ),
                            ),
                          ),
                        );
                      },
                    )),

              ));
        }) : MyLoading();
  }
}
