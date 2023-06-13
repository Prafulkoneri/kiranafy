

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_supper_market/widget/buttons.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}



class _MapState extends State<Map> {
  late GoogleMapController googleMapController;
  Position ? position;

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {
    // Marker(
    //   markerId: MarkerId("default"),
    //   position: initialCameraPosition.target,
    //   icon: BitmapDescriptor.defaultMarker,
    //   draggable: true,
    //   infoWindow: InfoWindow(title:"Manek Ratna-Imitaltion & Fashion Jewellery",snippet: "3rd Floor, Block No. 304, Ryna Arcade, Haji Zakeria Rd, Navy Colony, Mamledarwadi, Malad West, Mumbai, Maharashtra 400064"),
    //   visible: true,
    //   flat: true,
    //   onDrag: (position){
    //     print(position);
    //   }
    // ),
  };



  @override
  void initState() {
    getCurrentPosition();
  }

  getCurrentPosition()async{
    position = await _determinePosition();

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position?.latitude??0.0, position?.longitude??0.0), zoom: 14)));


    markers.clear();

    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position?.latitude??0.0, position?.longitude??0.0), icon: BitmapDescriptor.defaultMarker,
      draggable: true,
      // infoWindow: InfoWindow(title:"Manek Ratna-Imitaltion & Fashion Jewellery",snippet: "3rd Floor, Block No. 304, Ryna Arcade, Haji Zakeria Rd, Navy Colony, Mamledarwadi, Malad West, Mumbai, Maharashtra 400064"),
      visible: true,
      flat: true,
      onDrag: (position){
        print("helloo");
        print(position.latitude);
      },
      onDragStart:(position){
        print("helloo start");
        print(position.latitude);
      },
      onDragEnd: (position){
        print("helloo end");
        print(position.latitude);
      },

    ));

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(

            initialCameraPosition: initialCameraPosition,
            markers: Set<Marker>.of(
              <Marker>[
                Marker(
                    onTap: () {
                      print('Tapped');
                    },
                    draggable: true,
                    markerId: MarkerId('Marker'),
                    position: LatLng(position?.latitude??0.0, position?.longitude??0.0),
                    onDragEnd: ((newPosition) {
                      print(newPosition.latitude);
                      print(newPosition.longitude);
                    }))
              ],
            ),
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),

          Positioned(
            top: 100,
            child: PrimaryButton(color: Colors.blue, onTap:()async{

            },child: Text("Current Location"),),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {


        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
