


import 'package:firebase_auth/firebase_auth.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/data/shared_preference.dart';
import 'package:visab_admin/models/models.dart';

class FirebaseAuthAdmin{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseRepoAdmin _firebaseRepoAdmin = FirebaseRepoAdmin();
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<Admin> createAdmin(String name, String email, String password, String imageUrl) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      print("admin created....");
      Admin admin = Admin(_authResult.user.uid,name,_authResult.user.email,imageUrl);
      if (await _firebaseRepoAdmin.createNewAdmin(admin)) {
        return admin;
      }
      else{
        throw Exception("Error while registering\n ");
      }
    } catch (e) {
      throw Exception("Error while registering\n " + e.toString());
    }
  }

  Future<Admin> login(String email, String password) async {
    try {
      UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
       Admin admin = await _firebaseRepoAdmin.getAdmin(_authResult.user.uid);
      SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedIn);
      return admin;

    } catch (e) {
      throw Exception("Error while signing in\n " + e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedOut);

      return true;
    } catch (e) {
      throw Exception("Error while signing out\n " + e.toString());
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch(e){
      throw Exception(e);
    }
  }


}