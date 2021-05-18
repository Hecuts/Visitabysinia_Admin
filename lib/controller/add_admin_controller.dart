
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:visab_admin/data/firebase_auth_admin.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/models/models.dart';
import 'package:visab_admin/util/constants.dart';

class AddAdminController extends GetxController {

  Rx<bool> isFormValid = false.obs;
  Rx<bool> isUploading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();
  FirebaseAuthAdmin _authAdmin = FirebaseAuthAdmin();
  Rx<String> emptyFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;
  ImagePicker picker;
  var _pickedFile;
  var imageSelectionText = "Select a picture".obs;
  FirebaseRepoAdmin _firebaseRepoAdmin;


  @override
  void onInit() {
    _firebaseRepoAdmin = FirebaseRepoAdmin();
    picker = ImagePicker();
    super.onInit();
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile != null) {
      imageSelectionText.value = "Selected successfully";
    } else {
      imageSelectionText.value = "Select a picture";
    }
  }

  void clear() {
    emailController.clear();
    nameController.clear();
    pwController.clear();
    confirmPwController.clear();
  }

  void createAdmin(String imageURl) async{
    try {

      await _authAdmin.createAdmin(nameController.text, emailController.text, pwController.text, imageURl);
      Timer(Duration(seconds: 5000),()=>isUploading.value = false);
    }
    catch (e) {
      isUploading.value = false;
    }
  }

  Future uploadImageToFirebase(File _imageFile, String fileName) async {
    return await _firebaseRepoAdmin.uploadImageToFirebase(fileName, _imageFile, ImageType.admin);
  }

  void onSubmitPressed() async{
    if (validate()) {
      var splitted = _pickedFile.path.split('/');
      String fileName = splitted[splitted.length - 1];
      isUploading.value = true;
      String url = await uploadImageToFirebase(File(_pickedFile.path), fileName);
      createAdmin(url);
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
    if(checkEmptyField(nameController.text.trim())||checkEmptyField(emailController.text.trim()) || checkEmptyField(pwController.text.trim()) || checkEmptyField(confirmPwController.text.trim())){
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

/*  (json['reviews'] as List<dynamic>)
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList(),
    Geometry.fromJson(json['geometry'] as Map<String, dynamic>),*/