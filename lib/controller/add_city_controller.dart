


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/models/city.dart';
import 'package:visab_admin/models/location.dart';
import 'package:visab_admin/util/constants.dart';

class AddCityController extends GetxController{

  Rx<bool> isFormValid = false.obs;
  Rx<bool> isUploading = false.obs;
  TextEditingController nameController ;
  TextEditingController latitudeController;
  TextEditingController longitudeController;
  TextEditingController descriptionController;
  Rx<String> emptyFieldError = "".obs;
  ImagePicker picker;
  FirebaseRepoAdmin _firebaseRepoAdmin;
  var _pickedFile;
  var imageSelectionText = "Select a picture".obs;
  @override
  void onInit() {
    picker = ImagePicker();
    latitudeController = TextEditingController();
    nameController = TextEditingController();
    longitudeController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
    _firebaseRepoAdmin = FirebaseRepoAdmin();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clear();
  }

  void clear(){
    latitudeController.clear();
    nameController.clear();
    longitudeController.clear();
    descriptionController.clear();
  }

  void pickImage() async{
    _pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    if(_pickedFile != null){
      imageSelectionText.value = "Selected successfully";
    }else{
      imageSelectionText.value = "Select a picture";
    }


  }
  Future uploadImageToFirebase(File _imageFile, String fileName) async {
    return await _firebaseRepoAdmin.uploadImageToFirebase(fileName, _imageFile, ImageType.city);

  }

  void createCity(String imageUrl) async{
    String key = Uuid().v4();
    print("key : " + key);
    City city = City(key,nameController.text.trim(),imageUrl,descriptionController.text.trim(),Location(double.parse(latitudeController.text.trim()),double.parse(longitudeController.text.trim())));
    print("City to be created : ${city.toString()}");
    try {
      if(!await _firebaseRepoAdmin.createNewCity(city)){
        print("Unable to add a new city to firebase firestore database...");
      }
      isUploading.value = false;
    }
    catch(e){
    }
  }

  void onSubmitPressed() async{
    if (validate()) {
      var splitted = _pickedFile.path.split('/');
      String fileName = splitted[splitted.length - 1];
      isUploading.value = true;
      String url = await uploadImageToFirebase(File(_pickedFile.path), fileName);
      createCity(url);
    }else{
      Get.snackbar("Validation error", "forms are not valid");
    }

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
    if(checkEmptyField(latitudeController.text.trim())||checkEmptyField(nameController.text.trim()) || checkEmptyField(descriptionController.text.trim()) || checkEmptyField(longitudeController.text.trim())){
      print("invalidity while checking for empty fields");
      isFormValid.value = false;
      isValid = false;
      emptyFieldError.value = "Please, enter a valid input";
    }
    if(isValid == true){
      isFormValid.value = true;
    }
    return isValid;
  }
}