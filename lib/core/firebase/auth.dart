import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/authentication/authenticate.dart';
import '../utils/shared_preferences.dart';

class Auth {

  static Future<void> funcLogin(String email,String pass) async {

   await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: pass.trim()).then((value) {
     Auth.funcGetUser(FirebaseAuth.instance.currentUser!.uid).then((value) {
       HelperFunction.saveUserTypeSharedPreference(value.get("type"));
       HelperFunction.saveUserLoggedInSharedPreference(true);
       HelperFunction.saveUserNameSharedPreference(value.get("name"));
       HelperFunction.saveUserEmailSharedPreference(value.get("email"));

     });
   });




  }
  static Future<void> funcSignUp(String name,String phone,String email,String pass) async {

   await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: pass);


  }
  static Future<void> funcSaveUser(Map<String, Object> userMap,String uid) async {
     await FirebaseFirestore.instance.collection('users').doc(uid).set(userMap);
  }


  static Future<void> funcLogout(BuildContext context) async {

   await FirebaseAuth.instance
        .signOut();
   HelperFunction.saveUserLoggedInSharedPreference(false);
   Navigator.of(context).pushAndRemoveUntil(
       MaterialPageRoute(builder: (context) => const Authenticate()),
           (Route<dynamic> route) => false);


  }


  static Future<QuerySnapshot<Map<String, dynamic>>> funcGetWorkers(String type) async {
   Query<Map<String,dynamic>> snapshot=  FirebaseFirestore.instance.collection('users').where("type",isEqualTo: type);
   return snapshot.get();
  }
  static Future<DocumentSnapshot<Map<String, dynamic>>> funcGetUser(String uid) async {
   DocumentReference<Map<String,dynamic>> snapshot=  FirebaseFirestore.instance.collection('users').doc(uid);
   return snapshot.get();
  }



  static Future<QuerySnapshot<Map<String, dynamic>>> funcGetSkills() async {
    Query<Map<String,dynamic>> snapshot=  FirebaseFirestore.instance.collection('skills');
    return snapshot.get();
  }
}