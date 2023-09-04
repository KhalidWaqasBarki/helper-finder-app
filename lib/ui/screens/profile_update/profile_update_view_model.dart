import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../core/firebase/auth.dart';
import '../../../core/models/worker_model.dart';
class ProfileUpdateProvider extends ChangeNotifier{
ProfileUpdateProvider(){
  getSkills().whenComplete(() =>  getUser());

}



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
  _emailController.clear();
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


setNameText(String nameController) {
  _nameController.text=nameController ;
  notifyListeners();
}

setPhoneText(String phoneController) {
  _phoneController.text = phoneController;
  notifyListeners();
}

setEmailText(String emailController) {
  _emailController.text = emailController;
  notifyListeners();
}



setPasswordText(String passController) {
  _passController.text = passController;
  notifyListeners();
}

setAddressText(String addressController) {
  _addressController.text = addressController;
  notifyListeners();
}
setSkillText(String skillController) {
  _skillController.text = skillController;
  notifyListeners();
}
setOtherSkillText(String otherSkillController) {
  _otherSkillController.text = otherSkillController;
  notifyListeners();
}
setWageText(String wageController) {
  _wageController.text = wageController;
  notifyListeners();
}
setNoteText(String noteController) {
  _noteController.text = noteController;
  notifyListeners();
}
bool _isUser=false;
bool get isUser=>_isUser;
setIsUser(bool u){
  _isUser=u;
  notifyListeners();
}
bool _isFirstPage=true;
bool get isFirstPage=>_isFirstPage;
setIsFirstPage(bool u){
  _isFirstPage=u;
  notifyListeners();
}
WorkerModel? _user;
WorkerModel? get user=>_user;
setUser(WorkerModel wm){
  _user=wm;
  setIsUser(true);
  notifyListeners();
}




bool _availableSunday=true;
bool get availableSunday=>_availableSunday;
setAvailableSunday(bool u){
  _availableSunday=u;
  notifyListeners();
}
bool _showProfile=true;
bool get showProfile=>_showProfile;
setShowProfile(bool u){
  _showProfile=u;
  notifyListeners();
}
  void getUser() {
    Auth.funcGetUser(FirebaseAuth.instance.currentUser!.uid).then((value) {

      String name="${value.get("name")}";
      String lat="${value.get("lat")}";
      String long="${value.get("long")}";
      String skill="${value.get("skill")}";
      String skillNo="${value.get("skillNo")}";
      String additionalSkill="${value.get("otherSkills")}";
      String address="${value.get("address")}";
      String phone="${value.get("phone")}";
      String type="${value.get("type")}";
      String uid="${value.get("uid")}";
      String wage="${value.get("wage")}";
      String email="${value.get("email")}";
      String note="${value.get("note")}";
      String createdAt="${value.get("createdAt")}";
      bool showProfile=(value.get("showProfile"));
      bool availableSunday=(value.get("availableSunday"));
      double lat2=double.parse(lat);
      double lon2=double.parse(long);



      setOtherSkillText(additionalSkill);
      setWageText(wage);
      setNoteText(note);
      setAvailableSunday(availableSunday);
      setShowProfile(showProfile);

      setDropDownVal(int.parse(skillNo)-1);

      setNameText(name);
      setEmailText(email);
      setPhoneText(phone);
      setAddressText(address);



      WorkerModel wm=WorkerModel(name,skill,skillNo,lat,long,type,address,createdAt,email,phone,uid,wage,additionalSkill,"0",availableSunday,showProfile,note);
      setUser(wm);
      notifyListeners();
    });
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

