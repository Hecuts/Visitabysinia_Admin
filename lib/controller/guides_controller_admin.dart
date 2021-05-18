import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';
import 'package:visab_admin/controller/add_admin_controller.dart';
import 'package:visab_admin/controller/add_guide_controller.dart';
import 'package:visab_admin/data/firebase_auth_admin.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/models/models.dart' as model;
import 'package:visab_admin/models/models.dart';
import 'admin_auth_controller.dart';

class GuidesController extends GetxController with SingleGetTickerProviderMixin{
  Rx<List<model.TourGuide>> _guides = Rx<List<model.TourGuide>>(List.empty());
  Rx<List<model.Admin>> _admins = Rx<List<model.Admin>>(List.empty());


  Rx<List<model.TourGuide>> get guides => _guides;
  Rx<List<model.Admin>> get admins => _admins;

  FirebaseRepoAdmin _firebaseRepo = FirebaseRepoAdmin();
  FirebaseAuthAdmin _authAdmin = FirebaseAuthAdmin();

  TabController tabController;

  @override
  void onInit() {
    tabController = new TabController(length: 2, vsync: this);
    _guides.bindStream(_firebaseRepo.getGuides());
    _admins.bindStream(_firebaseRepo.getAdmins());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  void removeGuide(String id){
      try{
          _firebaseRepo.removeGuide(id);
      }catch(e){
      }
  }

  void removeAdmin(String id){
    try{
      _firebaseRepo.removeAdmin(id);
    }catch(e){
    }
  }
  void signOut(){
    Get.find<AdminAuthController>().signOut();
  }
}