

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}



class _MapState extends State<Map> {
  BitmapDescriptor? bitmapDescriptor;

  setMarker() async {
    // bitmapDescriptor =await createCustomMarkerBitmap("");
  }

  CameraPosition defaultPosition = CameraPosition(target: LatLng(19.1842651, 72.8412921), zoom: 14);



  @override
  void initState() {
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0.0, 0.0),
          )
        ]),
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
            markers: {
              Marker(
                onTap: () {
                  print('Tapped');
                },
                onDragEnd: ((newPosition) {
                  print(newPosition.latitude);
                  print(newPosition.longitude);
                }),
                markerId: MarkerId("default"),
                position: defaultPosition.target,
                icon: BitmapDescriptor.defaultMarker,
                draggable: true,
                infoWindow: InfoWindow(
                    title: "Manek Ratna-Imitaltion & Fashion Jewellery",
                    snippet:
                        "3rd Floor, Block No. 304, Ryna Arcade, Haji Zakeria Rd, Navy Colony, Mamledarwadi, Malad West, Mumbai, Maharashtra 400064"),
                visible: true,
                flat: true,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: defaultPosition),
      ),
    );
  }
}
