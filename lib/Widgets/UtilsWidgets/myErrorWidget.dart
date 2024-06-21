import 'package:flutter/cupertino.dart';

import '../../Utils/values.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("Page indisponnible",
              style: TextStyle(
                color: HelpitalColors.myColorPrimary,
                fontSize: 25
              ),
            ),
            Text("Nous rencontrons des problèmes de réseaux"),
          ],
        )
      ),
    );
  }
}
