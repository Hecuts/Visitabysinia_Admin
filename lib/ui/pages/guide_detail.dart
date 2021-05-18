import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/guides_controller_admin.dart';
import 'package:visab_admin/models/models.dart';

class GuideDetail extends GetView<GuidesController> {
  final int index;

  GuideDetail(this.index);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    TourGuide tourGuide = controller.guides.value.elementAt(index);
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
                                new NetworkImage(tourGuide.imageUrl),
                            radius: _height / 10,
                          ),
                          new SizedBox(
                            height: _height / 30,
                          ),
                          new Text(
                            tourGuide.name,
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
                          onPressed: () {controller.removeGuide(tourGuide.tourGuideId);
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
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [Text("Description", style: Theme.of(context).textTheme.subtitle1,),SizedBox(height: 8,),Padding(
                                    padding: const EdgeInsets.only( left : 8.0, bottom: 8.0),
                                    child: Text(tourGuide.description),
                                  ),],),
                              ),
                              ListTile(
                                title: Text(tourGuide.email),
                                leading: Icon(Icons.email),
                              ),
                              ListTile(
                                title: Text(tourGuide.phone),
                                leading: Icon(Icons.call),
                              ),
                              ListTile(
                                title: Text(tourGuide.city),
                                leading: Icon(Icons.location_city),
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
