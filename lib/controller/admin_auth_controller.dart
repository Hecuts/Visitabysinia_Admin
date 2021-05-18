
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/login_state.dart';
import 'package:visab_admin/data/firebase_auth_admin.dart';
import 'package:visab_admin/data/shared_preference.dart';
import 'package:visab_admin/models/models.dart';
import 'package:visab_admin/ui/pages/admin_home.dart';

class AdminAuthController extends GetxController {
  var state = LoginState.initial.obs;
  Rx<bool> isFormValid = false.obs;
  FirebaseAuthAdmin _firebaseAuthAdmin = FirebaseAuthAdmin();
  Rx<Admin> admin = Rx<Admin>(Admin.initial());
  Rx<String> emptyFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;
  TextEditingController pwController = TextEditingController();
  TextEditingController emailController = TextEditingController();


//User get user => _firebaseUser.value;

  @override
  onInit() {
    state.value = LoginState.initial;
    super.onInit();
    //_firebaseUser.bindStream(_firebaseAuthService.firebaseAuth.authStateChanges());
  }

  void createAdmin(String name, String email, String password,String imageUrl) async {
    try{
      admin.value = await _firebaseAuthAdmin.createAdmin(name, email, password,imageUrl);
    } catch (e) {

    }
  }

  void login() async {
    print("login called....");
    try {
      Admin admin = await _firebaseAuthAdmin.login(emailController.text.trim(), pwController.text.trim());
      this.admin.value = admin;
      state.value = LoginState.loaded;
      Get.offAll(()=>AdminHome());
    } catch (e) {
      state.value = LoginState.error;
      Get.snackbar("Error Message", "Error occurred while logging in");
    }
  }

  void signOut() async {
    try {
      bool result = await _firebaseAuthAdmin.signOut();
      if(result){
        admin.value  = Admin.initial();
      }
    } catch (e) {
      Get.snackbar("Error", "Error occurred while logging in");
    }
  }


  void onLoginPressed() async{
    if (validate()) {
      state.value = LoginState.loading;
      login();
    }else{
      Get.snackbar("Validation error", "forms are not valid");
    }

  }
  bool isEmailValid(String value){
    if(!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
        r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
        r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
        r"(?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool checkEmptyField(String value){
    if(value == null || value.isEmpty){
      return true;
    }
    return false;
  }

  bool validate(){
    bool isValid = true;
    emptyFieldError.value = "";
    invalidEmailError.value = "";
    if(checkEmptyField(pwController.text.trim())){
      print("invalidity while checking for empty fields");
      isFormValid.value = false;
      isValid = false;
      emptyFieldError.value = "Please, enter a valid input";
    }
    if(checkEmptyField(emailController.text.trim()) || !isEmailValid(emailController.text.trim())){
      print("invalidity while checking for empty fields email part ");
      invalidEmailError.value = "Please, enter a valid email";
      isFormValid.value = false;
      isValid = false;

    }
    if(isValid == true){
      isFormValid.value = true;
    }
    return isValid;
  }


}