import 'package:flutter/cupertino.dart';

class MyCustomScrollView extends StatelessWidget {
  Widget child;
  MyCustomScrollView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
        constraints: BoxConstraints(
        minHeight: viewportConstraints.maxHeight,
      ),
    child: child
        )
      );
        }
        );
  }
}
