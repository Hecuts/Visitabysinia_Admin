import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/guides_controller_admin.dart';
import 'package:visab_admin/models/admin.dart';

class AdminDetailNew extends GetView<GuidesController> {

  final int index;

  AdminDetailNew(this.index);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    Admin admin = controller.admins.value.elementAt(index);
    return new Stack(children: <Widget>[
      new Container(
        decoration:
            new BoxDecoration(color: Theme.of(context).primaryColor),
      ),
      new Scaffold(
          backgroundColor: Colors.transparent,
          body: new Container(
            child: new Stack(
              children: <Widget>[
                new Align(
                  alignment: Alignment.center,
                  child: new Padding(
                    padding: new EdgeInsets.symmetric(vertical: _height / 25),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundImage:
                              new NetworkImage(admin.imageUrl),
                          radius: _height / 10,
                        ),
                        new SizedBox(
                          height: _height / 30,
                        ),
                        new Text(
                          admin.name,
                          style: new TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: _height / 3),
                  child: new Container(
                    color: Colors.white,
                    child: Align(
                      child: Container(
                        padding:
                            EdgeInsets.only(bottom: 16, top: 3, left: 3),
                        child: MaterialButton(
                          minWidth: 120,
                          height: 40,
                          onPressed: () {
                            Get.defaultDialog(title: "Remove",
                                middleText: "Are you sure, wanna remove this admin?"
                                ,
                                textCancel: "No",
                            onCancel: ()=>{Get.back()},
                                onConfirm: (){
                                  controller.removeAdmin(admin.id);
                                  Get.back();
                                },
                            textConfirm: "Yes");

                          },
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(
                      top: _height / 3.4,
                      left: _width / 25,
                      right: _width / 25),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: _height / 20),
                    child: ListTile(
                      title: Text(admin.email),
                      leading: Icon(Icons.email),
                    ),
                  ),
                )
              ],
            ),
          ))
    ]);
  }
}

Widget buildSubmissionButton(
    BuildContext context, VoidCallback onPressed, String buttonText) {
  return Container(
    padding: EdgeInsets.only(top: 3, left: 3),
    child: MaterialButton(
      minWidth: 120,
      height: 40,
      onPressed: () {
        onPressed();
      },
      color: Theme.of(context).primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
      ),
    ),
  );
}
