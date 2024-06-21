import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import '../../../../Utils/values.dart';
import 'package:helpital_mobile_app/View/Directory/blockInfoUser.dart';
import 'package:helpital_mobile_app/Widgets/PatternPages/pageScrollableDefault.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';

import '../../Models/User/User.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../Widgets/UtilsWidgets/myListBuilder.dart';


class Directory extends StatefulWidget {
  const Directory({Key key}) : super(key: key);

  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory>
    with SingleTickerProviderStateMixin {
  List<User> usersList;
  String searchValue;
  void setSearchingList(String value) {
    List<User> bufferUser = [];
    if (value != null) {
      usersList.forEach((element) {
        if (element.firstName.contains(value) || element.lastName.contains(value)) {
          bufferUser.add(element);
        }
      });
      usersList = bufferUser;
    }
  }
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    return PageScrollableDefault(
      title: MySearchingBar(
        currentInput: (value) {
          if (usersList != null) {
            setState(() {
              searchValue = value;
            });
          }
        },
      ),
      core: buildListOfUser(context),
    );
  }

  Widget buildListOfUser(BuildContext context) {
    return Container(
        child: FutureBuilder<List<User>>(
          future: UserService().getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              usersList = snapshot.data;
              setSearchingList(searchValue);
              return MyListBuilder(
                list: usersList,
                builder: (context, index) {
                  return MyAnimationListBuilder(
                    index: index,
                    child: BlockInfoUser(user: usersList[index]),
                  );
                },
              );
            }
          },
        )
    );
  }
}