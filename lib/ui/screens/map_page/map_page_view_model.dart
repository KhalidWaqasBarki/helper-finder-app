import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helper_finder/core/utils/shared_preferences.dart';
import '../../../core/firebase/auth.dart';
import '../../../core/models/worker_model.dart';
import '../../../core/utils/calculate_distance.dart';
import '../show_worker_page/show_worker_page.dart';

class MapProvider extends ChangeNotifier {
  BuildContext context;
  List<LatLng> polylineCoordinates = [];

  Set<Marker> markers = {}; //markers for google map

  LatLng _showLocation =  LatLng(34.034367452345975, 71.5310488366664);


  LatLng get showLocation => _showLocation;

  setLocation(LatLng showLocation) {
    _showLocation = showLocation;
    notifyListeners();
  }

  PolylinePoints polylinePoints = PolylinePoints();

  Map<PolylineId, Polyline> polylines = {};
  LatLng startLocation = const LatLng(34.018433270357484, 71.64880853356321);
  LatLng endLocation = const LatLng(33.999080598959814, 71.42015559439913);

  //location to show in map

  MapProvider(this.context) {
mainFunc();
  }//contrller for Google map
  mainFunc(){
    _determinePosition().then((value) {
      setPosition(value);
      setLocation(LatLng(position.latitude, position.longitude));

      setChange();

      notifyListeners();

      getWorkers();
      notifyListeners();
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController>  get controller => _controller;


  // late GoogleMapController _mapController;
  // GoogleMapController get mapController=> _mapController;


  void setController(Completer<GoogleMapController> controller) {
    _controller = controller;
    
    notifyListeners();
  }

  double _distance = 0.0;

  double get distance => _distance;

  setDistance(double distance) {
    _distance = distance;
    notifyListeners();
  }

/*

  Future<void> generatePolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      if (kDebugMode) {
        print(result.errorMessage);
      }
    }

    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
   notifyListeners();
    calculateDistanceX();
  }
  calculateDistanceX(){
    double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i+1].latitude,
          polylineCoordinates[i+1].longitude);
    }
    if (kDebugMode) {
      print(totalDistance);
    }

    setDistance(totalDistance);
    notifyListeners();

  }
*/

  List<WorkerModel> wList = [];

  Future<void> getWorkers() async {
    await HelperFunction.getUserTypeSharedPreference().then((value) {
      if (value != null) {
        String typee=value=="worker"?"client":"worker";
        Auth.funcGetWorkers(typee).then(
          (res) {
            for (int i = 0; i < res.docs.length; i++) {
              String name = "${res.docs[i].get("name")}";
              String lat = "${res.docs[i].get("lat")}";
              String long = "${res.docs[i].get("long")}";
              String skill = "${res.docs[i].get("skill")}";
              String skillNo = "${res.docs[i].get("skill")}";
              String additionalSkill = "${res.docs[i].get("otherSkills")}";
              String address = "${res.docs[i].get("address")}";
              String phone = "${res.docs[i].get("phone")}";
              String type = "${res.docs[i].get("type")}";
              String uid = "${res.docs[i].get("uid")}";
              String wage = "${res.docs[i].get("wage")}";
              String email = "${res.docs[i].get("email")}";
              String note = "${res.docs[i].get("note")}";
              String createdAt = "${res.docs[i].get("createdAt")}";
              bool showProfile = (res.docs[i].get("showProfile"));
              bool availableSunday = (res.docs[i].get("availableSunday"));
              double lat2 = double.parse(lat);
              double lon2 = double.parse(long);
              String kms = calculateDistance(
                      showLocation.latitude, showLocation.longitude, lat2, lon2)
                  .toString();

              wList.add(WorkerModel(
                  name,
                  skill,
                  skillNo,
                  lat,
                  long,
                  type,
                  address,
                  createdAt,
                  email,
                  phone,
                  uid,
                  wage,
                  additionalSkill,
                  kms,
                  availableSunday,
                  showProfile,
                  note));
              notifyListeners();

              double latx = double.parse(res.docs[i].get("lat"));
              double longx = double.parse(res.docs[i].get("long"));

              String kmss = "${kms.toString()} Kms";
              markers.add(Marker(
                //add distination location marker
                markerId: MarkerId(res.docs[i].id),
                position: LatLng(latx, longx), //position of marker
                infoWindow: InfoWindow(
                  //popup info
                  title: name,
                  snippet: kmss,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkerProfilePage(
                                  model: wList[i],
                                )));
                  },
                ),

                icon: BitmapDescriptor.defaultMarker, //Icon for Marker
              ));
              notifyListeners();
              notifyListeners();
            }
            notifyListeners();
          },
          onError: (e) => print("Error completing: $e"),
        );
        notifyListeners();
      }
    });
  }

  late Position pos;

  setPosition(Position p) {
    pos = p;
    notifyListeners();
  }

  Position get position => pos;

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

  Future<void>  setChange() async {

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: showLocation,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414)));

    notifyListeners();
  }

}
