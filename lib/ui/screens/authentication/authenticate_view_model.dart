import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/shared_preferences.dart';
import '../main_page/main_page_screen.dart';
class AuthProvider extends ChangeNotifier{
  BuildContext? context;
  AuthProvider({this.context});

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);


  Key key= const ValueKey('SignIn');
  bool _showSignIn=true;
  bool _isLogin=true;

  bool get showSignIn=>_showSignIn;
  bool get isLogin=>_isLogin;
  late AnimationController _controller;
  setController(AnimationController controller){

    _controller =controller;
  }
  get controller=>_controller;
   setShowSignIn(bool showSignIn){
    _showSignIn=showSignIn;
    showSignIn?
      _controller.forward():_controller.reverse();
    key=showSignIn?
     const ValueKey('SignIn'):const ValueKey('SignUp');

    notifyListeners();
  }
   setLogin(bool isLogin){
    _isLogin=isLogin;
    notifyListeners();
  }

  void toggleView() {

      _showSignIn = !_showSignIn;
      showSignInPage.value=_showSignIn;
      showSignIn?
      _controller.reverse():_controller.forward();
      key=showSignIn?
      const ValueKey('SignIn'):const ValueKey('SignUp');

    notifyListeners();
  }

  Future<void> getLogin() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        if (value) {
          String  uid=FirebaseAuth.instance.currentUser!.uid;
          if (uid!=null && uid!=""){
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context!).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false);
          }
        }
      }
    });
  }



  // getPermissions() async {
  //
  //   Map<Permission, PermissionStatus> statuses = await [
  //   Permission.location,
  //       Permission.storage,
  //   ].request();
  //   print(statuses[Permission.location]);
  // }
}