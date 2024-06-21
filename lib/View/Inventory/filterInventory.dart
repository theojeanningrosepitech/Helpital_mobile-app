import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/mySelectorFilter.dart';

import 'package:helpital_mobile_app/Utils/values.dart';

class FilterInventory extends StatefulWidget {
  Function(Filter) getCurrentFilter;
  List<bool> selector;
  FilterInventory({
    this.getCurrentFilter,
    this.selector
  });
  @override
  _FilterInventoryState createState() => _FilterInventoryState(
    getCurrentFilter: this.getCurrentFilter,
    selector: this.selector
  );
}

class _FilterInventoryState extends State<FilterInventory> {

  Function(Filter) getCurrentFilter;
  List<bool> selector;
  _FilterInventoryState({
    this.getCurrentFilter,
    this.selector
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Wrap(
          children: [
            MySelectorFilter(
              name: 'Appareil Médical',
              index: 0,
              isSelected: selector[0],
              boxSelected: () {
                getCurrentFilter(Filter.appareilMedical);
              },

            ),
            MySelectorFilter(
              isSelected: selector[1],
              name: 'Outil Médical',
              index: 1,
              boxSelected: (){
                getCurrentFilter(Filter.outilMedical);
              },

            ),
            MySelectorFilter(
              isSelected: selector[2],
              name: 'Appareil électronique',
              index: 2,
              boxSelected: () {
                getCurrentFilter(Filter.medicalDevice);
              },

            ),
            MySelectorFilter(
              isSelected: selector[3],
              name: 'Équipement Chirurgicale',
              index: 3,
              boxSelected: () {
                getCurrentFilter(Filter.surgeryTool);
              },

            )
          ],
        ),
      )
    );
  }
}
