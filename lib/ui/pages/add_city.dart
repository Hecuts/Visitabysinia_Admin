
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/add_city_controller.dart';
import 'package:visab_admin/ui/widgets/custom_input_filed.dart';
import 'package:visab_admin/ui/widgets/select_pic.dart';

import 'admin_home.dart';


class AddCity extends GetWidget<AddCityController> {
  AddCityController controller = Get.put(AddCityController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add City"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Obx(()=>Container(
                padding: EdgeInsets.only( top: 20, left: 20, right: 20),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child:false == true? Center(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20,),
                    Text("Uploading city information...."),
                  ],
                )) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomInputField(label: "Name",controller: controller.nameController, errorMsg: controller.emptyFieldError.value),
                    CustomInputField(label: "Description",controller: controller.descriptionController, errorMsg: controller.emptyFieldError.value,),
                    CustomInputField(label: "Latitude", controller : controller.latitudeController,errorMsg: controller.emptyFieldError.value,isNumber: true,),
                    CustomInputField(label: "Longitude", controller : controller.longitudeController,errorMsg: controller.emptyFieldError.value, isNumber: true,),
                    SizedBox(height: 20,),
                    TakePictureWidget(controller.imageSelectionText, controller.pickImage),
                    SizedBox(height: 20,),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        child: MaterialButton(
                          minWidth: 120,
                          height: 40,
                          onPressed: () {
                            controller.onSubmitPressed();
                            if(controller.isFormValid.value){
                              Get.to(()=>AdminHome());
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            )
            )));
  }
}
