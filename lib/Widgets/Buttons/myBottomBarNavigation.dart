
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'myButtonClass.dart';

class MyAppBarCustom extends StatefulWidget {
  final int count;
  final VoidCallback onCountSelected;
  final Function(int) onCountChanged;
  final List<MyButton> buttonWidget;

  MyAppBarCustom({
    @required this.count,
    @required this.onCountChanged,
    @required this.buttonWidget,
    this.onCountSelected,
  });

  @protected
  _MyAppBarCustomState createState() => _MyAppBarCustomState(
      onCountChanged: this.onCountChanged,
      onCountSelected: this.onCountSelected,
      buttonWidget: this.buttonWidget,
      count: this.count);
}

class _MyAppBarCustomState extends State<MyAppBarCustom> {
  int page = 0;

  final int count;
  final VoidCallback onCountSelected;
  final Function(int) onCountChanged;
  final List<MyButton> buttonWidget;
  double sizeBar = 60;
  bool barIsOpen = false;

  _MyAppBarCustomState({
    @required this.count,
    @required this.buttonWidget,
    @required this.onCountChanged,
    this.onCountSelected,
  });
  Alignment sizeBarAlign = Alignment(1, 1);

  double maxSizeOfBar;
  List<Widget> buttonFinalNav = [];

  void genButtonNav() {
    this.buttonWidget.forEach((element) {
      buttonFinalNav.add(
          buildBottomNavButton(element.icon, element.title, element.index));
    });
  }
  void calcSizeOfBar() {
    double numberOfWidget = this.buttonWidget.length / 4;
    int buf = numberOfWidget.ceil();
    maxSizeOfBar = (buf * 60).toDouble();

  }
  @protected
  Widget build(BuildContext context) {
    buttonFinalNav = [];
    genButtonNav();
    calcSizeOfBar();
    return buildNavBar(context);
  }

  void openBar() {
    setState(() {
      sizeBar = maxSizeOfBar;
      barIsOpen = true;
    });
  }
  void closeBar() {
    setState(() {
      sizeBar = 60;
      barIsOpen = false;
    });
  }
  void myOnVerticalDragUpdate(details) {
    int sensitivity = 8;
    if (details.delta.dy < -sensitivity) {
      openBar();
    } else if (details.delta.dy > -sensitivity) {
      closeBar();
    }
  }

  void myButtonBarOnTap() {
    setState(() {
      if (barIsOpen) {
        closeBar();
      } else {
        openBar();
      }
    });
  }

  void myOnPressedButton(index) {
    closeBar();
    onCountChanged(index);
    page = index;
  }
  Widget buildNavBar(BuildContext context) => Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: HelpitalColors.black,
                  blurRadius: 5,
                ),
              ],
              color: HelpitalColors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: BottomAppBar(
                    child:  GestureDetector(
                        onVerticalDragUpdate: (details) => myOnVerticalDragUpdate(details),
                        child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: HelpitalColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        height: sizeBar,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              Center(
                                child: Wrap(
                                  children: buttonFinalNav,
                                ),
                              ),
                              buildopenNavBarButton(),
                            ],
                          ),
                        )
                        )
                    )
                )
            ),
  );

  Widget buildBottomNavButton(icon, text, index) {
    var _color = HelpitalColors.myColorTextIcon;
    var size = MediaQuery.of(context).size;

    if (index == page) {
      _color = HelpitalColors.myColorPrimary;
    }

    return Container(
      height: 60,
      width: size.width * 0.25,
      child: TextButton(
        onPressed: () => myOnPressedButton(index),
        child: Column(
          // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(icon, color: _color, size: 30,),
            Text(
              text,
              style: TextStyle(
                  fontSize: -text.length * 0.5 + 14,
                  color: HelpitalColors.myColorTextIcon
              )
              ,)
          ],
        ),
      ),
    );
  }

  @protected
  Widget buildopenNavBarButton() => Container(
    height: 20,
    child: Center(
      child: InkWell(
      onTap: myButtonBarOnTap,
      child: Container(
        padding: EdgeInsets.only(
          left: 130,
          right: 130,
          top: 3,
          bottom: 15
        ),
        child: Container(
          color: HelpitalColors.myColorTextGrey,

        ),
      )
    ),
  ));
}
