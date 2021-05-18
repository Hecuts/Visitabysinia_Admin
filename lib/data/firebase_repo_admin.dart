import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visab_admin/models/models.dart';
import 'package:visab_admin/util/constants.dart';


class FirebaseRepoAdmin {
  FirebaseFirestore _firestore;
  Reference firebaseStorageRef;

  FirebaseRepoAdmin(){
    this._firestore = FirebaseFirestore.instance;
    this.firebaseStorageRef =  FirebaseStorage.instance.ref();
  }

  Future<bool> createNewAdmin(Admin admin) async {
    try {
      await _firestore.collection("admins").doc(admin.id).set(admin.toJson());
      print("Admin created....");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<bool> createNewGuide(TourGuide guide) async {
    try {
      await _firestore.collection("guides").doc(guide.tourGuideId).set(guide.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> createNewCity(City city) async {
    try {
      await _firestore.collection("cities").doc(city.cityId).set(city.toJson());
      return true;
    } catch (e) {
      print("Error while adding a city to database. With error message of :  " + e.toString());
      return false;
    }
  }


  Stream<List<TourGuide>> getGuides(){
    return _firestore.collection("guides").snapshots().map((QuerySnapshot query)
    {
      List<TourGuide> guides = [];
      query.docs.forEach((element) {
        guides.add(TourGuide.fromDocumentSnapshot(element));
      });
      return guides;
    });
  }

  Future<TourGuide> getGuide(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("guides").doc(uid).get();

      return TourGuide.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> removeGuide(String id) async {
    try{
      await _firestore.collection("guides").doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<bool> removeAdmin(String id) async {
    try{
      await _firestore.collection("admins").doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }


  Future<Admin> getAdmin(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("admins").doc(uid).get();

      return Admin.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<Admin>> getAdmins(){
    return _firestore.collection("admins").snapshots().map((QuerySnapshot query)
    {
      List<Admin> users = [];
      query.docs.forEach((element) {
        print("user id " + element.id);
        users.add(Admin.fromDocumentSnapshot(element));
      });
      return users;
    });
  }

  Future<String> uploadImageToFirebase(String fileName, File imageFile, ImageType imageType) async {
    // type here used to identify the owner of the picture if 0 => admin , 1 => tour guide , 2=>

    String imageDirectory = "tour_guides_profiles";
    if(imageType == ImageType.admin){
      imageDirectory = "admins_profiles";
    }
    else if(imageType == ImageType.city){
      imageDirectory = "cities_profiles";
    }
    UploadTask uploadTask = firebaseStorageRef.child("$imageDirectory/$fileName").putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
   // $name found in $formatted_address
}