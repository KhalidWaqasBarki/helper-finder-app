import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class SignInProvider extends ChangeNotifier{


  SignInProvider(){


    _determinePosition().then((value) => setPosition(value));
  }




  bool _rememberMe=false;
  bool get rememberMe=>_rememberMe;
  setRememberMe(bool val){
    _rememberMe=val;
    notifyListeners();
  }




  late Position pos;
  setPosition(Position p){
    pos=p;
    notifyListeners();
  }
  Position get position=>pos;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  TextEditingController get emailController=>_emailController;
  TextEditingController get passController=>_passController;

  setEmail(TextEditingController emailController){
    _emailController=emailController;
    notifyListeners();
  }
  setEmailClear(){
    _emailController.clear();
    notifyListeners();
  }
  setPassClear(){
    _passController.clear();
    notifyListeners();
  }
  setPassword(TextEditingController passController){
    _passController=passController;
    notifyListeners();
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

}