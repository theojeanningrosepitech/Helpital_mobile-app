import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/cookiesService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import '../../../Widgets/PatternPages/pageSettingsDefault.dart';
import '../../../Widgets/UtilsWidgets/myLoading.dart';
import '../../Note/stateDialog.dart';

class FavorisManager extends StatefulWidget {
  @override
  _FavorisManagerState createState() => _FavorisManagerState();
}

class _FavorisManagerState extends State<FavorisManager> {
  List<String> _list = [];
  _FavorisManagerState() {
    CookiesService().getFavorisList().then((value) => setState(() => _list = value));
  }
  @override
  Widget build(BuildContext context) {

    return PageSettingsDefault(
        action: [
          IconButton(
              onPressed: () async {
                if (_list != null) {
                  bool result = await CookiesService().initNewFavorisList(_list);
                  if (result) {
                    await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => StateDialog(
                          title: 'Succée',
                          content: 'Vos Favoris ont été modifié avec succée',
                          color: HelpitalColors.green,
                        )
                    );
                    Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
                  }
                }
              },
              icon: Icon(Icons.send, color: HelpitalColors.myColorTextIcon,)
          )
        ],
        name: 'Favoris',
        child: _list != null ? buildCore() : MyLoading()

    );
  }
  Widget buildCore() {
    return Center(
      child: ReorderableListView(
        children: _list.map((item) => ListTile(key: Key("${item}"), title: Text("${item}"), trailing: Icon(Icons.menu),)).toList(),
        onReorder: (int start, int current) {
          // dragging from top to bottom
          if (start < current) {
            int end = current - 1;
            String startItem = _list[start];
            int i = 0;
            int local = start;
            do {
              _list[local] = _list[++local];
              i++;
            } while (i < end - start);
            _list[end] = startItem;
          }
          // dragging from bottom to top
          else if (start > current) {
            String startItem = _list[start];
            for (int i = start; i > current; i--) {
              _list[i] = _list[i - 1];
            }
            _list[current] = startItem;
          }
          setState(() {});
        },
      ),


    );
  }
}
