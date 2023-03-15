import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'Alert.dart';


class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => UserLocationScreenState();
}

class UserLocationScreenState extends State<UserLocationScreen> {

  StreamSubscription? _locationSubscription;
  Location _locationTracker = Location();
  Circle circle = Circle(circleId: CircleId('car'));
  Marker marker = Marker(markerId: MarkerId('home'));
  final List<Marker> _markers = [];

  late GoogleMapController _controller;
  static final CameraPosition initialLocation = CameraPosition(
      target: LatLng(37.42796133580664, -122.08574955962),
  zoom: 14);

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/icons8-user-96.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData)async{
    LatLng latLng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    await get_live_location();
    this.setState(() {
      _markers[0] = Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation:   newLocalData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5 , 0.5),
        icon: BitmapDescriptor.fromBytes(imageData));

      _markers[1] = Marker(
        draggable: true,
        markerId: MarkerId('Animal'),
        infoWindow: InfoWindow(
          title: "Animal"
        ),
        // position: LatLng(33.74635825443523, 73.00529534884603),
        position: live_location,
        icon: BitmapDescriptor.defaultMarker,
      );


      circle = Circle(
        circleId: CircleId("car"),
        radius: 20.0,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70));
    });
  }



  void getCurrentLocation() async{
    try{
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();


      updateMarkerAndCircle(location , imageData);

      if(_locationSubscription != null){
        _locationSubscription!.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        // _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        //   bearing: 192.83340901395799,
        //   target: _markers[1].position,
        //   //LatLng(newLocalData.latitude! , newLocalData.longitude!),
        //   tilt: 0,
        //   zoom: 18.00
        // )));


        double abc = Geolocator.distanceBetween(_markers[0].position.latitude, _markers[0].position.longitude,
            _markers[1].position.latitude, _markers[1].position.longitude);
        NotificationWidget.showNotifications(title: "ALERT", body: "Animal Near You", payload: FlutterLocalNotificationsPlugin());

        String distance = abc.toStringAsFixed(4);
        Fluttertoast.showToast(msg: distance);
        updateMarkerAndCircle(newLocalData , imageData);
        setState(() {

        });
      });
    }
    on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED'){
        debugPrint('Permission Denied');
      }
    }
  }
  LatLng live_location = LatLng(33.76543968, 73.234523525);
  get_live_location() async{
    await FirebaseFirestore.instance
        .collection('location')
        .doc("ZVs9bLumD3XVY4mETi13")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        // Fluttertoast.showToast(msg: documentSnapshot["lat"]);
        live_location =  LatLng(double.parse(documentSnapshot["lat"]), double.parse(documentSnapshot["lng"]));
      } else {
        Fluttertoast.showToast(msg: "No document");
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationWidget.init();
    _markers.add(marker);
    Marker animal = Marker(
      draggable: true,
      markerId: MarkerId('Animal'),
      // position: LatLng(33.74635825443523, 73.00529534884603),
      position: live_location,
      icon: BitmapDescriptor.defaultMarker,
    );
    _markers.add(animal);

  }

  void dispose(){
    if(_locationSubscription != null){
      _locationSubscription!.cancel();
    }
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: _markers.toSet(),
        // Set.of(marker !=null ? [marker] : []),
        // circles: Set.of(circle !=null ? [circle] : []),
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.location_searching),
        onPressed: () async {
          getCurrentLocation();
          Fluttertoast.showToast(msg: "Again");
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            bearing: 192.83340901395799,
            target: _markers[0].position,
            //LatLng(newLocalData.latitude! , newLocalData.longitude!),
            tilt: 0,
            zoom: 18.00
          )));
          // double double_distance = double.parse(distance);

        },
      ),
    );
  }
}
