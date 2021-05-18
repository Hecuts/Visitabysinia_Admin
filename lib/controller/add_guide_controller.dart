import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/models/models.dart';
import 'package:visab_admin/util/constants.dart';

class AddGuideController extends GetxController {
  Rx<bool> isFormValid = false.obs;
  Rx<bool> isUploading = false.obs;
  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController languagesController;
  TextEditingController contactController;
  TextEditingController cityController;
  TextEditingController descriptionController;
  Rx<String> emptyFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;
  ImagePicker picker;
  var _pickedFile;
  FirebaseRepoAdmin _firebaseRepoAdmin;

  var imageSelectionText = "Select a picture".obs;
  var selectedValue = "Male".obs;

  var dropdownItems = ["Male", "Female"];

  @override
  void onInit() {
    picker = ImagePicker();
    emailController = TextEditingController();
    nameController = TextEditingController();
    languagesController = TextEditingController();
    contactController = TextEditingController();
    cityController = TextEditingController();
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

  void clear() {
    emailController.clear();
    nameController.clear();
    contactController.clear();
    languagesController.clear();
    cityController.clear();
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

  Future uploadImageToFirebase(File _imageFile, String fileName) async {
    return await _firebaseRepoAdmin.uploadImageToFirebase(
        fileName, _imageFile, ImageType.tourGuide);
  }

  void createGuide(String imageUrl) async {
    String key = Uuid().v4();
    print("key : " + key);
    TourGuide guide = TourGuide(
        key,
        nameController.text.trim(),
        imageUrl,
        descriptionController.text.trim(),
        languagesController.text.split(','),
        "Male",
        cityController.text.trim(),
        emailController.text.trim(),
        contactController.text.trim());
    try {
      await _firebaseRepoAdmin.createNewGuide(guide);
      isUploading.value = false;
    } catch (e) {}
  }

  void onSubmitPressed() async {
    if (validate()) {
      var splitted = _pickedFile.path.split('/');
      String fileName = splitted[splitted.length - 1];
      isUploading.value = true;
      String url =
          await uploadImageToFirebase(File(_pickedFile.path), fileName);
      createGuide(url);
    } else {
      Get.snackbar("Validation error", "forms are not valid");
    }
  }

  bool isEmailValid(String value) {
    if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
            r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
            r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
            r"(?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool checkEmptyField(String value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  bool validate() {
    bool isValid = true;
    emptyFieldError.value = "";
    invalidEmailError.value = "";
    if (checkEmptyField(contactController.text.trim()) ||
        checkEmptyField(nameController.text.trim()) ||
        checkEmptyField(descriptionController.text.trim()) ||
        checkEmptyField(languagesController.text.trim()) ||
        checkEmptyField(cityController.text.trim())) {
      print("invalidity while checking for empty fields");
      isFormValid.value = false;
      isValid = false;
      emptyFieldError.value = "Please, enter a valid input";
    }
    if (checkEmptyField(emailController.text.trim()) ||
        !isEmailValid(emailController.text.trim())) {
      print("invalidity while checking for empty fields email part ");
      invalidEmailError.value = "Please, enter a valid email";
      isFormValid.value = false;
      isValid = false;
    }
    if (isValid == true) {
      isFormValid.value = true;
    }
    return isValid;
  }

  void onDropDownSelection(String value) {
    this.selectedValue.value = value;
  }
}
