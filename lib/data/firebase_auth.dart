import 'package:firebase_auth/firebase_auth.dart';
import 'package:visab_admin/data/firebase_repo_admin.dart';
import 'package:visab_admin/models/models.dart';

class FirebaseAuthService{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseRepoAdmin _firebaseRepo = FirebaseRepoAdmin();

  Future<Admin> createAdmin(String name, String email, String password, String phone,String imageUrl) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      Admin _user = Admin(_authResult.user.uid,name,_authResult.user.email,imageUrl);
      if (await _firebaseRepo.createNewAdmin(_user)) {
        return _user;
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
        Admin user = await _firebaseRepo.getAdmin(_authResult.user.uid);
        return user;

    } catch (e) {
          throw Exception("Error while signing in\n " + e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
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