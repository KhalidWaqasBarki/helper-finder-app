import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/firebase/auth.dart';
import '../../../core/models/worker_model.dart';
class ProfileProvider extends ChangeNotifier{
ProfileProvider(){
  getUser();
}


bool _isUser=false;
bool get isUser=>_isUser;
setIsUser(bool u){
  _isUser=u;
  notifyListeners();
}
WorkerModel? _user;
WorkerModel? get user=>_user;
setUser(WorkerModel wm){
  _user=wm;
  setIsUser(true);
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
      WorkerModel wm=WorkerModel(name,skill,skillNo,lat,long,type,address,createdAt,email,phone,uid,wage,additionalSkill,"0",availableSunday,showProfile,note);
      setUser(wm);
      notifyListeners();
    });
  }
}

