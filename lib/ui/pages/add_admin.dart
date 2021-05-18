import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/add_admin_controller.dart';
import 'package:visab_admin/ui/widgets/custom_input_filed.dart';
import 'package:visab_admin/ui/widgets/select_pic.dart';

import 'admin_home.dart';

class AddAdmin extends GetWidget<AddAdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add Admin"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                // edit the height and the padding of this container
                //width: double.infinity,
                child: GetX<AddAdminController>(
                    init: Get.put(AddAdminController()),
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
                                Text("Uploading admin's information...."),
                              ],
                            ));
                      } else {
                        return Column(
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
                              label: "Password",
                              controller: controller.pwController,
                              errorMsg: controller.emptyFieldError.value,
                            ),
                            CustomInputField(
                              label: "Confirm Password",
                              controller: controller.confirmPwController,
                              errorMsg: controller.emptyFieldError.value,
                              isPhone: true,
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
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
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
                        );
                      }
                    }))));
  }
}
