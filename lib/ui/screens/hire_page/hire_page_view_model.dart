import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helper_finder/core/models/hire_model.dart';
import 'package:helper_finder/core/utils/calculate_distance.dart';

import '../../../core/firebase/auth.dart';
import '../../../core/models/worker_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/shared_preferences.dart';
class HireProvider extends ChangeNotifier{


HireProvider(){
  _determinePosition().then((value) {
    setPosition(value);
    showLocation= LatLng(position.latitude,position.longitude);
    notifyListeners();
    getWorkers();
    notifyListeners();
  });
}


LatLng showLocation = LatLng(34.034367452345975, 71.5310488366664);
  var hireOptions = <Widget>[];



  List<WorkerModel> wList=[];
  List<WorkerModel> wListFilter=[];
  filterWorker(int val){
    print("object  $val");
    setIsLoaded(false);
    wListFilter.clear();
    for(int i=0; i<wList.length; i++){
      print("object i= $i");
      print("object skillNo= ${wList[i].skillNo}");

      if(int.parse(wList[i].skillNo)==val){
        print("Added");
        wListFilter.add(wList[i]);
      }
    }
    setIsLoaded(true);
    print("object  $val");

  }
Future<void> getWorkers() async {
  await HelperFunction.getUserTypeSharedPreference().then((value) {
    if(value!=null){
      String typee=value=="worker"?"client":"worker";
      Auth.funcGetWorkers(typee).then(
            (res) {
              print("Data SucessFully retrived");
              print("${res.docs.length}");
              print("${res.docs[0].get("lat")}");
              for(int i=0; i<res.docs.length; i++){
                String name="${res.docs[i].get("name")}";
                String lat="${res.docs[i].get("lat")}";
                String long="${res.docs[i].get("long")}";
                String skill="${res.docs[i].get("skill")}";
                String skillNo="${res.docs[i].get("skillNo")}";
                String additionalSkill="${res.docs[i].get("otherSkills")}";
                String address="${res.docs[i].get("address")}";
                String phone="${res.docs[i].get("phone")}";
                String type="${res.docs[i].get("type")}";
                String uid="${res.docs[i].get("uid")}";
                String wage="${res.docs[i].get("wage")}";
                String email="${res.docs[i].get("email")}";
                String note="${res.docs[i].get("note")}";
                String createdAt="${res.docs[i].get("createdAt")}";
                bool showProfile=(res.docs[i].get("showProfile"));
                bool availableSunday=(res.docs[i].get("availableSunday"));
                double lat2=double.parse(lat);
                double lon2=double.parse(long);
                String kms=calculateDistance(showLocation.latitude, showLocation.longitude, lat2, lon2).toString();

                wList.add(WorkerModel(name,skill,skillNo,lat,long,type,address,createdAt,email,phone,uid,wage,additionalSkill,kms,availableSunday,showProfile,note));
                wListFilter.add(WorkerModel(name,skill,skillNo,lat,long,type,address,createdAt,email,phone,uid,wage,additionalSkill,kms,availableSunday,showProfile,note));

                _x++;
                if(_x+1==res.docs.length){
                  setIsLoaded(true);
                }
                print("Data SuccessFully x $x");
                print("Data SuccessFully sixe ${wListFilter.length}");
                print("Data SuccessFully sixe ${isLoaded}");
                notifyListeners();
                notifyListeners();
                print("Data SuccessFully retrived");

              }

          notifyListeners();
        },
        onError: (e) => print("Error completing: $e"),
      );
      notifyListeners();
    }
  });

}
int _x=0;
int get x=>_x;
bool _isLoaded=false;
bool get isLoaded=>_isLoaded;
setIsLoaded(bool xv){
  _isLoaded=xv;
  notifyListeners();
  notifyListeners();
}




late Position pos;
setPosition(Position p){
  pos=p;
  notifyListeners();
}
Position get position=>pos;
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