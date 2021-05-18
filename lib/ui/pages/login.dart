import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/admin_auth_controller.dart';
import 'package:visab_admin/controller/login_state.dart';
import 'package:visab_admin/controller/reset_password_controller.dart';
import 'package:visab_admin/ui/pages/admin_home.dart';
import 'package:visab_admin/ui/pages/reset_password.dart';
import 'package:visab_admin/ui/widgets/custom_input_filed.dart';


class LoginPage extends GetWidget<AdminAuthController> {

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: new Text("Login", style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: GetX<AdminAuthController>(
                  builder:(controller){
                    return  Column(
                    children: <Widget>[
                      CustomInputField(label: "Email", controller: controller.emailController,errorMsg: controller.invalidEmailError.value,),
                      CustomInputField(
                          label: "Password",
                          obscureText: true,
                          controller: controller.pwController, errorMsg: controller.emptyFieldError.value,),
                    ],
                  );},
                ),
              ),
              GetX<AdminAuthController>(
                  builder:(controller){
                   /* if(controller.isFormValid.value && controller.state.value == LoginState.loaded){
                      Get.to(() => AdminHome());
                    }*/
                    return   Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          color: Colors.white,
                          child: Align(child:  Container(
                            padding: EdgeInsets.only(bottom: 3, top: 3, left: 3),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () { controller.onLoginPressed();
                              },
                              color: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: controller.state.value == LoginState.loading ? CircularProgressIndicator(backgroundColor: Colors.white,):
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ), alignment: Alignment.bottomCenter,),
                        ),
                      ),
                      SizedBox(height: 8,),
                      TextButton(onPressed:  () => Get.bottomSheet(Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top : 20),
                        height : MediaQuery.of(context).size.height/3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomInputField(label: "Email",controller: resetPasswordController.emailController, errorMsg: resetPasswordController.invalidEmailError.value, hint: "Password reset link will be sent to this email...",),
                            SizedBox(height: 20,),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                child: MaterialButton(
                                  minWidth: 120,
                                  height: 40,
                                  onPressed: () {
                                    resetPasswordController.onSubmitPressed();
                                    if(resetPasswordController.isFormValid.value){
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
                        ),
                      ), backgroundColor: Colors.white),//Get.to(() => ResetPassword()
                        child:Text( controller.state.value == LoginState.loading ?"Validating user data...":
                        "Forget password?",
                          style: TextStyle(fontSize: 14),
                        ),)
                    ],
                  );}
    ),
            ],
          ),
        ),
      ),
    );
  }
}
