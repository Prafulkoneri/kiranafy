import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapView extends StatefulWidget {
  const MapView({ Key? key }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  //get MapView controller to access MapView
  Completer<GoogleMapController> _googleMapViewController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  TextEditingController searchController =TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = LatLng(11, 104);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 17.5 // number of MapView view
    );

    //MapView will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      //get a float button to click and go to current location
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gotoUserCurrentPosition();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
        children : [
          _getMapView(),
          _getCustomPin(),
          _showSearchBox()
        ]
    );
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(child: Text(_draggedAddress, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
      ),
    );
  }

  Widget _showSearchBox() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 19.w,left: 16.w,right: 16.w),
        width: MediaQuery.of(context).size.width,
        height: 48.w,
        child: Container(
          child: GooglePlaceAutoCompleteTextField(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp
              ),
              textEditingController: searchController,
              googleAPIKey: "AIzaSyCm27F5Jrl8b6vXkNCOotiTdnM8QeygfOY",
              inputDecoration: InputDecoration(
                hintText: "Search location",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xffB7B7B7),
                  fontWeight: FontWeight.w400,
                ),
                prefix: Padding(
                  padding:  EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset("assets/icons/search_MapView.svg"),
                ),
                contentPadding: EdgeInsets.only(left: 10.w),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffE4E4E4),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder:   OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffE4E4E4),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              debounceTime: 800, // default 600 ms,
              countries: ["in","fr"], // optional by default null is set
              isLatLngRequired:true,// if you required coordinates from place detail
              getPlaceDetailWithLatLng: (prediction) {
                _gotoSpecificPosition(LatLng(double.parse(prediction.lat.toString()), double.parse(prediction.lng.toString())));

                // this method will return latlng with place detail
                print("placeDetails" + prediction.lng.toString());
              }, // this callback is called when isLatLngRequired is true
              itmClick: (Prediction prediction) {
                searchController.text=prediction.description.toString();
                searchController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
              }
          ),
        ),
      ),
    );

  }

  Widget _getMapView() {
    return GoogleMap(
      initialCameraPosition: _cameraPosition!, //initialize camera position for MapView
      mapType: MapType.normal,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on MapView
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on MapView
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
        print(_draggedLatlng);
        // _getAddress(_draggedLatlng);
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when MapView is fully loaded
        if (!_googleMapViewController.isCompleted) {
          //set controller to google MapView when it is fully loaded
          _googleMapViewController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: Container(
        width: 61,
        height: 61,
        child: Image.asset("assets/images/MapView_icon.png"),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr = "${address.street}, ${address.locality}, ${address.postalCode}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
    print(_draggedAddress);
  }

  //get user's current location and set the MapView's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {

    GoogleMapController MapViewController = await _googleMapViewController.future;
    MapViewController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: position,
            zoom: 17.5
        )
    ));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if(!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if(locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

}
