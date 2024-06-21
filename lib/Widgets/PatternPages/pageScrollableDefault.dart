import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class PageScrollableDefault extends StatefulWidget {

  Widget title;
  Widget subTitle;
  Widget core;

  PageScrollableDefault({Key key, this.title, this.subTitle, this.core}) : super(key: key);

  @override
  _PageScrollableDefaultState createState() => _PageScrollableDefaultState(
    title: title,
    subTitle: subTitle,
    core: core,
  );
}

class _PageScrollableDefaultState extends State<PageScrollableDefault> with SingleTickerProviderStateMixin {
  Widget title;
  Widget subTitle;
  Widget core;

  _PageScrollableDefaultState({this.title, this.subTitle, this.core});
  List<Widget> listWidgetTitle = [];
  TabController controller;
  void setListTitle() {
    if (title != null) {
      listWidgetTitle.add(SliverAppBar(
          backgroundColor: HelpitalColors.white,
          title: title
      ),);
    }
    if (subTitle != null) {
      listWidgetTitle.add(SliverAppBar(
          expandedHeight: 100,
          collapsedHeight: 60,
          backgroundColor: HelpitalColors.white,
          flexibleSpace: subTitle
      ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    setListTitle();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelpitalColors.white,
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return listWidgetTitle;
            },
            body: Container(
              height: SizeCustom().assignHeight(context: context, fraction: 0.8),
              child: core,
            )
        ),
      ),
    );
  }
}