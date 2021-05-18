import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/guides_controller_admin.dart';
import 'package:visab_admin/models/models.dart';
import 'package:visab_admin/ui/pages/add_city.dart';
import 'package:visab_admin/ui/pages/admin_detail.dart';
import 'package:visab_admin/ui/pages/admin_detail_new.dart';
import 'package:visab_admin/ui/pages/guide_detail.dart';
import 'package:visab_admin/ui/pages/login.dart';
import 'package:visab_admin/ui/widgets/guide_item.dart';
import 'package:visab_admin/util/constants.dart';
import 'add_admin.dart';
import 'add_guide.dart';

//https://picsum.photos/200/300?random=1

class AdminHome extends GetWidget<GuidesController> {
  GuidesController controller;
  AdminHome(){
    controller = Get.put<GuidesController>(GuidesController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Home", style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,),
        ),
        actions:  <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Scaffold(
              appBar: TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.w600),
                  indicatorColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey.shade500,
                  controller: controller.tabController,
                  tabs: <Widget>[
                    Tab(text: "Tour Guides"),
                    Tab(text: "Admins",)
                  ]),
              body: TabBarView(
                children: <Widget>[
                  _buildGuidesGridList(context),
                  _buildAdminsGridList(context),
                ],
                controller: controller.tabController,
              )),
      ),
      );
  }

  _buildGuidesGridList(BuildContext context) {
    return
      GetX<GuidesController>(
          builder: (GuidesController controller) {
          if (controller != null && controller.guides != null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,),
                      itemCount: controller.guides.value.length,
                      itemBuilder: (_, index) {
                        TourGuide tourGuide = controller.guides.value.elementAt(index);
                        return GestureDetector(
                            onTap: ()=>{Get.to(()=>GuideDetail(index))},
                            child: GuideWidget(tourGuide.tourGuideId,tourGuide.name,tourGuide.imageUrl));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: MaterialButton(
                      minWidth: 120,
                      height: 40,
                      onPressed: ()=>Get.to(()=>AddGuide()),
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Add Guide",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text("loading...");
          }
        },
      );
  }


  _buildAdminsGridList(BuildContext context) {
    return
      GetX<GuidesController>(
        builder: (GuidesController controller) {
          if (controller != null && controller.admins != null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,),
                      itemCount: controller.admins.value.length,
                      itemBuilder: (_, index) {
                        Admin admin = controller.admins.value.elementAt(index);
                        return GestureDetector(
                            onTap:  () => Get.bottomSheet(
                            AdminDetailNew(index),
                            backgroundColor: Colors.white),
                            child: GuideWidget(admin.id,admin.name,admin.imageUrl));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: MaterialButton(
                      minWidth: 120,
                      height: 40,
                      onPressed: ()=>Get.to(()=>AddAdmin()),
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Add Admin",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text("loading...");
          }
        },
      );
  }
  void choiceAction(String choice){
    if(choice == Constants.Settings){
      Get.snackbar("Test", "Option menu test for Settings");
    }else if(choice == Constants.addCity){
      Get.to(()=>AddCity());
    }else if(choice == Constants.SignOut){
      controller.signOut();
      Get.to(()=>LoginPage());
    }
  }
}
