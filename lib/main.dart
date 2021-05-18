import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/controller/bindings/auth_binding.dart';
import 'package:visab_admin/data/shared_preference.dart';
import 'package:visab_admin/ui/pages/admin_home.dart';
import 'package:visab_admin/ui/pages/login.dart';
import 'package:visab_admin/util/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Visab'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future:  SharedPreferenceUtil.getUserSessionStatus(),
        builder:(BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(),);
            default:
                  return decidePageBasedOnUserStatus(snapshot.data);

          }
        });
  }

  Widget decidePageBasedOnUserStatus(String currentStatus){
    print("Current status : $currentStatus...inside decidePageBasedOnStatus");
    if( currentStatus == SharedPreferenceUtil.loggedIn){
      print("User logged in already...");
        return AdminHome();
    }
    else if(currentStatus == SharedPreferenceUtil.loggedOut){
      print("User is not logged in");
      return LoginPage();
    }
    else{
      print("Checking user status");
      return Center(child: CircularProgressIndicator(),);
    }
  }
}
