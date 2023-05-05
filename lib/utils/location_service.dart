import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  late GoogleMapController googleMapController;
  static CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(18.520430, 73.856743), zoom: 14.w);
  Set<Marker> markers = {};


 Future<Position> determinePosition()async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location Service is Disabled");
    }
    permission=await Geolocator.checkPermission();

    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error("Location Service Denied");
      }
    }
    if(permission==LocationPermission.deniedForever){
      return Future.error("Location Service Pemanently denied");
    }
    Position position =await Geolocator.getCurrentPosition();
    return position;
  }
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          Position position = await determinePosition();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(position.latitude,position.longitude),zoom: 14.w)));
          markers.clear();
          markers.add(Marker(markerId: MarkerId("currentPosition"),position: LatLng(position.latitude,position.longitude)));
        },
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController=controller;
        },
      ),
    );
  }

}
