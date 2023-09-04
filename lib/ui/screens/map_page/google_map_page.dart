import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:provider/provider.dart';
import 'map_page_view_model.dart';
class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MapProvider(context),
        child: Consumer<MapProvider>(
          builder: (context, gmap, child) {
            return  Scaffold(
              appBar: AppBar(
                title: const Text("Map"),
                backgroundColor: kPrimaryColor,
              ),
              body: GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: gmap.showLocation, //initial position
                  zoom: 10.0, //initial zoom level
                ),



                markers: gmap.markers,
                polylines:  Set<Polyline>.of(gmap.polylines.values),//markers to show on map
                mapType: MapType.normal, //map type

                onMapCreated: (GoogleMapController controller) {
                  gmap.controller.complete(controller);

                  // _controller.complete(controller);

                },

              ),
            );
          },
        ));
  }
}
