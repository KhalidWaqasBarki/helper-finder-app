import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase/auth.dart';
import '../authentication/authenticate_view_model.dart';

class SignUpProvider extends ChangeNotifier {

  SignUpProvider(){

    getSkills();
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _skillController = TextEditingController();
  TextEditingController _otherSkillController = TextEditingController();
  TextEditingController _wageController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  TextEditingController get nameController => _nameController;

  TextEditingController get phoneController => _phoneController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passController => _passController;

  TextEditingController get addressController => _addressController;
  TextEditingController get skillController => _skillController;
  TextEditingController get otherSkillController => _otherSkillController;
  TextEditingController get wageController => _wageController;
  TextEditingController get noteController => _noteController;

  setName(TextEditingController nameController) {
    _nameController = nameController;
    notifyListeners();
  }

  setPhone(TextEditingController phoneController) {
    _phoneController = phoneController;
    notifyListeners();
  }

  setEmail(TextEditingController emailController) {
    _emailController = emailController;
    notifyListeners();
  }

  setEmailClear() {
    // _emailController.clear();
    notifyListeners();
  }

  setPassword(TextEditingController passController) {
    _passController = passController;
    notifyListeners();
  }

  setAddress(TextEditingController addressController) {
    _addressController = addressController;
    notifyListeners();
  }
  setSkill(TextEditingController skillController) {
    _skillController = skillController;
    notifyListeners();
  }
  setOtherSkill(TextEditingController otherSkillController) {
    _otherSkillController = otherSkillController;
    notifyListeners();
  }
  setWage(TextEditingController wageController) {
    _wageController = wageController;
    notifyListeners();
  }
  setNote(TextEditingController noteController) {
    _noteController = noteController;
    notifyListeners();
  }

  clearAll(BuildContext context){
     _nameController.clear();
     _phoneController.clear();
     _emailController.clear();
     _passController.clear();
     _addressController.clear();
     _skillController.clear();
     _otherSkillController.clear();
     _wageController.clear();
     _noteController.clear();
     final auth =
     Provider.of<AuthProvider>(context, listen: false);
     auth.toggleView();

     setSelectType(0);
  }
  int _selectType = 0;

  int get selectType => _selectType;

  setSelectType(int sType) {
    _selectType = sType;
    notifyListeners();
  }

  String _type = "";

  String get type => _type;

  setType(String sType) {
    _type = sType;
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


  bool _isListEmpty=false;
  bool get isListEmpty=>_isListEmpty;
  setIsListEmpty(bool val){
    _isListEmpty=val;
    notifyListeners();
  }

  int _dropDownVal=0;
  int get dropDownVal=>_dropDownVal;
  setDropDownVal(int val){
    _dropDownVal=val;
    notifyListeners();
    notifyListeners();
  }
  List<String> _dropDownItems =[];
  List<String> get dropDownItems=>_dropDownItems;
  addDropDownList(String val){
    _dropDownItems.add(val);
    notifyListeners();
    _isListEmpty=true;
    notifyListeners();
  }
  List<int> _dropDownItemsIds =[];
  List<int>  get dropDownItemsIds=>_dropDownItemsIds;
  addDropDownListIds(int val){
    _dropDownItemsIds.add(val);
    notifyListeners();
    _isListEmpty=true;
    notifyListeners();
  }



  Future<void> getSkills() async {
    Auth.funcGetSkills().then(
          (res) {
        print("Data SucessFully retrived");
        print("${res.docs.length}");

        for (int i = 0; i < res.docs.length; i++) {
          String id = "${res.docs[i].get("id")}";
          String skillName = "${res.docs[i].get("skillName")}";


          addDropDownListIds(int.parse(id));
          notifyListeners();
          addDropDownList(skillName);
          notifyListeners();
        }
        notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();


  }

}
