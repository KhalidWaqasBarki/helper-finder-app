
import 'dart:math';

double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p)/2 +
      cos(lat1 * p) * cos(lat2 * p) *
          (1 - cos((lon2 - lon1) * p))/2;
  double fn= 12742 * asin(sqrt(a));
  return dp(fn, 2);
}
double dp(double val, int places){
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}