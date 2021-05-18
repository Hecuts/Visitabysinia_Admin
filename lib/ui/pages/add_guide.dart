import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/add_guide_controller.dart';
import 'package:visab_admin/controller/guides_controller_admin.dart';
import 'package:visab_admin/ui/widgets/custom_drop_down.dart';
import 'package:visab_admin/ui/widgets/custom_input_filed.dart';
import 'package:visab_admin/ui/widgets/select_pic.dart';

import 'admin_home.dart';

class AddGuide extends GetWidget<AddGuideController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add Guide"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: GetX<AddGuideController>(
                  init: Get.put(AddGuideController()),
                  builder: (controller) {
                    if (controller.isUploading.value) {
                      return Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Uploading tour guide informations...."),
                        ],
                      ));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomInputField(
                                label: "Name",
                                controller: controller.nameController,
                                errorMsg: controller.emptyFieldError.value),
                            CustomInputField(
                              label: "Email",
                              controller: controller.emailController,
                              errorMsg: controller.invalidEmailError.value,
                            ),
                            CustomInputField(
                              label: "Languages",
                              controller: controller.languagesController,
                              errorMsg: controller.emptyFieldError.value,
                            ),
                            CustomInputField(
                              label: "Contact",
                              controller: controller.contactController,
                              errorMsg: controller.emptyFieldError.value,
                              isPhone: true,
                            ),
                            CustomInputField(
                              label: "City",
                              controller: controller.cityController,
                              errorMsg: controller.emptyFieldError.value,
                            ),
                            CustomInputField(
                              label: "Description",
                              controller: controller.descriptionController,
                              errorMsg: controller.emptyFieldError.value,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TakePictureWidget(controller.imageSelectionText,
                                controller.pickImage),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                child: MaterialButton(
                                  minWidth: 120,
                                  height: 40,
                                  onPressed: () {
                                    controller.onSubmitPressed();
                                    if (controller.isFormValid.value) {
                                      Get.to(() => AdminHome());
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ))));
  }
}
