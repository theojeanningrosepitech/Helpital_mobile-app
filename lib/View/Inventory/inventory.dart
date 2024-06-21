import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Services/inventoryService.dart';
import 'package:helpital_mobile_app/Widgets/PatternPages/pageScrollableDefault.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myListBuilder.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';

import '../../Models/Inventory/Inventory.dart';

import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import 'blockInfoInventory.dart';
import 'filterInventory.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  bool isAppareilMedical = false;
  bool isOutilMedical = false;
  bool isMedicalDevice = false;
  bool isSurgeryTool = false;
  List<Inventory> _listInventory;
  List<bool> listSelector;
  String searchValue;
  void setListSelector() {
    listSelector.insert(0, isAppareilMedical);
    listSelector.insert(1, isOutilMedical);
    listSelector.insert(2, isMedicalDevice);
    listSelector.insert(3, isSurgeryTool);
    listSelector.removeLast();
    listSelector.removeLast();
    listSelector.removeLast();
    listSelector.removeLast();
  }
  void setListOfObject() {
    if (isAppareilMedical ||  isOutilMedical || isMedicalDevice || isSurgeryTool) {
      List<Inventory> bufferList = [];
      if (isAppareilMedical) {
        _listInventory.forEach((element) {
          if (element.type.id == 3)
            bufferList.add(element);
        });
      }
      if (isOutilMedical) {
        _listInventory.forEach((element) {
          if (element.type.id == 1)
            bufferList.add(element);
        });
      }
      if (isMedicalDevice) {
        _listInventory.forEach((element) {
          if (element.type.id == 2)
            bufferList.add(element);
        });
      }
      if (isSurgeryTool) {
        _listInventory.forEach((element) {
          if (element.type.id == 0)
            bufferList.add(element);
        });
      }
      _listInventory = bufferList;
    }
  }

  void setFilter(Filter listFilter) {
    if (listFilter == Filter.appareilMedical) {
      setState(() {
        if (!isAppareilMedical)
          isAppareilMedical = true;
        else
          isAppareilMedical = false;
        setListSelector();

      });
    }
    if (listFilter == Filter.outilMedical) {
      setState(() {
        if (!isOutilMedical)
          isOutilMedical = true;
        else
          isOutilMedical = false;
        setListSelector();
      });
    }
    if (listFilter == Filter.medicalDevice) {
      setState(() {
        if (!isMedicalDevice)
          isMedicalDevice = true;
        else
          isMedicalDevice = false;
        setListSelector();
      });
    }
    if (listFilter == Filter.surgeryTool) {
      setState(() {
        if (!isSurgeryTool)
          isSurgeryTool = true;
        else
          isSurgeryTool = false;
        setListSelector();

      });
    }
  }

  void setListofSearch(String value) {
    List<Inventory> bufferSearch = [];
    if (value != null) {

    _listInventory.forEach((element) {
        if (element.title.contains(value)) {
          bufferSearch.add(element);
        }
    });
    _listInventory = bufferSearch;
    }
  }
  @override
  Widget build(BuildContext context) {
    if (listSelector == null) {
      listSelector = [
        isAppareilMedical,
        isOutilMedical,
        isMedicalDevice,
        isSurgeryTool
      ];
    }
    return Column(
      children: [
        MySearchingBar(
          currentInput: (value) {
            if (_listInventory != null) {
              setState(() {
                searchValue = value;

              });
            }
          },
        ),
        FilterInventory(
          getCurrentFilter: (Filter listFilter) {
            setFilter(listFilter);
          },
          selector: listSelector,
        ),
        buildListOfInventory(context),
      ],
    );
/*    return PageScrollableDefault(
      title: MySearchingBar(
        currentInput: (value) {
          if (_listInventory != null) {
            setState(() {
              searchValue = value;

            });
          }
        },
      ),
      subTitle: FilterInventory(
        getCurrentFilter: (Filter listFilter) {
          setFilter(listFilter);
        },
        selector: listSelector,
      ),
      core:buildListOfInventory(context),

    );*/

  }

  Widget buildListOfInventory(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        height: size.height*0.7,
        child: FutureBuilder(
          future: InventoryService().getInventoryList(),
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyLoading();
            }
            if (snapshot.hasError) {
              return MyErrorWidget();
            } else {
              _listInventory = snapshot.data;
              setListOfObject();
              setListofSearch(searchValue);
              return MyListBuilder(
                list: _listInventory,
                builder: (context, index) {
                  return MyAnimationListBuilder(
                    index: index,
                    child: BlockInfoInventory(
                        inventory: _listInventory[index]
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
