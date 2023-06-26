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
import 'package:http/http.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';

class MapScreenView extends StatefulWidget {
  final bool isLocationEnabled;
  final bool  initialMapView;
  final LatLng latLng;
  const MapScreenView({ Key? key,required this.isLocationEnabled,required this.initialMapView,required this.latLng}) : super(key: key);

  @override
  State<MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView> {

  //get MapView controller to access MapView
  Completer<GoogleMapController> _googleMapViewController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  TextEditingController searchController =TextEditingController();
  bool isLocationEnabledByUser=false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    final watch=Provider.of<MainScreenController>(context, listen: false);
    //set default latlng for camera position
    _defaultLatLng = widget.latLng;
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 17.5 // number of MapView view
    );
    isLocationEnabledByUser = widget.isLocationEnabled;
    print(widget.isLocationEnabled);
    print(widget.initialMapView);
    print("00000000");
    if(widget.isLocationEnabled&&widget.initialMapView){
      _gotoUserCurrentPosition();
    }



    //MapView will redirect to my current location when loaded

    print("zzzzzzz");
    print(isLocationEnabledByUser);
  }

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<MainScreenController>();
    final read=context.read<MainScreenController>();
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Container(
            height: 400.w,
            child: _buildBody()),
        !isLocationEnabledByUser?Container(
          height: 0,
        ):Positioned(
            top: -10.w,
            left: 0.w,
            right: 0.w,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Cross.svg',
                    width: 15.w,
                    height: 15.h,
                  ),
                ),
              ),
            )),
      ],
    );


    //   Scaffold(
    //   body:
    //   //get a float button to click and go to current location
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       _gotoUserCurrentPosition();
    //     },
    //     child: Icon(Icons.location_on),
    //   ),
    // );
  }

  Widget _buildBody() {
    return
      Stack(
          clipBehavior: Clip.none,
          children : [
            _getMapView(),
            _getCustomPin(),
            _showSearchBox(),
            !isLocationEnabledByUser? Positioned(bottom: 0.w,child: _locationEnabled(),left: 0.w,right: 0.w,):Container(),

          ]
      );

  }
  Widget _locationEnabled(){

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.w,
              spreadRadius: 20.w,
              color: Colors.white.withOpacity(0.9),
              offset: Offset(0,0),

            ),
          ]
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          Text("Enable your location",style: TextStyle(color: Black1,fontSize: 16.sp,),),
          SizedBox(
            height: 15.w,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32.w),

            child: PrimaryButton(color:Color(0xff2388FF), onTap:(){
              _defaultLatLng = LatLng(11, 104);
              _draggedLatlng = _defaultLatLng;
              _cameraPosition = CameraPosition(
                  target: _defaultLatLng,
                  zoom: 17.5 // number of MapView view
              );
              _gotoUserCurrentPosition();
            },text: "Allow while using this app",fontWeight: FontWeight.w500,fontSize: 12.sp,height: 40.w),
          ),
          SizedBox(
            height: 36.w,
          ),
        ],


      ),
    );
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.w,
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
                prefixIcon: Container(
                  height: 13.3.w,
                  width: 13.3.w,
                  child: Center(child: Container(child: SvgPicture.asset("assets/icons/search_map.svg",height: 13.3.w,width: 13.3.w,fit: BoxFit.contain,))),
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
    return
      ClipRRect(
        borderRadius:BorderRadius.only(topRight: Radius.circular(20.w),topLeft: Radius.circular(30.w)),
        child: GoogleMap(

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
        ),
      );

  }

  Widget _getCustomPin() {
    return Center(
      child: Container(
        width: 61.w,
        height: 61.w,
        child: Image.asset("assets/images/map_marker.png"),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    final read=Provider.of<MainScreenController>(context, listen: false);
    //this will list down all address around the position
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr = "${address.street}, ${address.locality}, ${address.postalCode}, ${address.country}";
    await read.setPincode(context,isLocationEnabledByUser,address.postalCode,LatLng(position.latitude, position.longitude));
    setState(() {
      _draggedAddress = addresStr;
    });
    print(_draggedAddress);
  }

  //get user's current location and set the MapView's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));

    isLocationEnabledByUser=true;

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
    setState(() {
      isLocationEnabledByUser=true;
    });
    ;
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
