

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/add_guide_controller.dart';

class CustomDropDown extends StatelessWidget {

  CustomDropDown();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,

          )
      ),
      child: GetX<AddGuideController>(
        builder: (controller) {
          return DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedValue.value,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 20,
            elevation: 15,
            style: const TextStyle(
            ),
            onChanged: (String newValue){
              controller.onDropDownSelection(newValue);
            },
            items: controller.dropdownItems
                .map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }
      ),
    );
  }
}
