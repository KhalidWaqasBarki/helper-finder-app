import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/core/utils/shared_preferences.dart';
import '../../../core/firebase/auth.dart';
import '../../../core/models/drawer_model.dart';
class MainProvider extends ChangeNotifier{

  BuildContext context;
  MainProvider(this.context){
    getUserData();
  }
  void getUserData() {
    HelperFunction.getUserNameSharedPreference().then((value) {
      setUsername(value!);
      HelperFunction.getUserEmailSharedPreference().then((valueX) {
        setUserEmail(valueX!);

        HelperFunction.getUserTypeSharedPreference().then((valueY) {
          setUserType(valueY!);

          //drawerInit();
        });
      });
    });
  }
  void drawerInit() {

    drawerOptions.add(Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor
      ),
      height: 200,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
             const Spacer(),
              const Spacer(),
              const CircleAvatar(
              radius: 40.0,
              backgroundImage:  AssetImage("assets/images/avatar.jpg"),
              // NetworkImage("${snapshot.data.hitsList[index].previewUrl}"),
              backgroundColor: Colors.transparent,
            ),
              const Spacer(),
              Text(
                _username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _userEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
          ],),
        ),
      ),
    ));
    for (var i = 0; i <drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(ListTile(
        title: Text(
          d.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
  }


 final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();

  get scaffoldKey=>_scaffoldKey;
  toggleScaffoldKey(){
    if (_scaffoldKey.currentState!.isDrawerOpen == false) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    notifyListeners();
  }


  String _username = "0";
  get username=>_username;
  setUsername(String uname) {
    _username = uname;

    notifyListeners();
  }
  String _userEmail = "0";
  get userEmail=>_userEmail;
  setUserEmail(String uemail) {
    _userEmail = uemail;

    notifyListeners();
  }

  String _userType = "0";
  get userType=>_userType;
  setUserType(String uType) {
    _userType = uType;

    notifyListeners();
  }



  int _selectedDrawerIndex = 0;
  get selectedDrawerIndex=>_selectedDrawerIndex;
  _onSelectItem(int index) {
    _selectedDrawerIndex = index;
    toggleScaffoldKey();
    if(selectedDrawerIndex==4){
      Auth.funcLogout(context!);
    }

    drawerOptions.clear();
    drawerInit();
    notifyListeners();
  }
  var drawerOptions = <Widget>[];
  final drawerItems = [
    DrawerItem("Home "),
    DrawerItem("Settings"),
    DrawerItem("Contact Us"),
    DrawerItem("About Us"),
    DrawerItem("Logout"),

  ];




}