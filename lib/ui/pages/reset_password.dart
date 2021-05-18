
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/admin_auth_controller.dart';
import 'package:visab_admin/controller/reset_password_controller.dart';
import 'package:visab_admin/ui/widgets/custom_input_filed.dart';

class ResetPassword extends GetWidget<ResetPasswordController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Reset Password"),
          elevation: 0,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            height: MediaQuery
                .of(context)
                .size
                .height*0.5,
            // edit the height and the padding of this container
            //width: double.infinity,
            child:  GetX<ResetPasswordController>(
              init : Get.put(ResetPasswordController()),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomInputField(label: "Email",controller: controller.emailController, errorMsg: controller.invalidEmailError.value, hint: "Password reset link will be sent to this email...",),
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
                              Get.back();
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Send",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            )));
  }
}
