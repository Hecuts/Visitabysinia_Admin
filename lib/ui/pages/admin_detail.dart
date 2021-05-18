import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/guides_controller_admin.dart';
import 'package:visab_admin/models/models.dart';

class AdminDetail extends GetView<GuidesController> {
  final int index;

  AdminDetail(this.index);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    Admin admin = controller.admins.value.elementAt(index);
    return new Container(
      child: new Stack(
        children: <Widget>[
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
                      padding: new EdgeInsets.only(top: _height / 15),
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
                    padding: new EdgeInsets.only(top: _height / 2.5),
                    child: new Container(
                      color: Colors.white,
                      child: Align(child:  Container(
                        padding: EdgeInsets.only(bottom: 16, top: 3, left: 3),
                        child: MaterialButton(
                          minWidth: 120,
                          height: 40,
                          onPressed: () {controller.removeAdmin(admin.id);
                          Get.back();},
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
                      ), alignment: Alignment.bottomCenter,),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.only(top: _height / 20),
                          child: new Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(admin.email),
                                leading: Icon(Icons.email),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
