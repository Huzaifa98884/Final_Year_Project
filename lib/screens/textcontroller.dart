import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Text_Contoller extends StatefulWidget {
  const Text_Contoller({Key? key}) : super(key: key);

  @override
  State<Text_Contoller> createState() => _Text_ContollerState();
}

class _Text_ContollerState extends State<Text_Contoller> {

  final animal_id_controller = TextEditingController();
  final animal_name_controller = TextEditingController();
  String? lat;
  String? lng;
  LatLng? currentPostion;
  void getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high
    ));

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      lat = position.latitude.toString();
      lng = position.longitude.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
            "Enter details",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            EnterText.textfield(context, animal_id_controller, "Lat", 1),
            EnterText.textfield(context, animal_name_controller, "Long", 1),
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white)),
              elevation: 5,
              color: Colors.teal.shade800,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.3,
                onPressed: () async {
                  if(animal_name_controller.text == null || animal_id_controller.text == null){
                    Fluttertoast.showToast(msg: "Enter all fields");
                  }
                  else{
                    await FirebaseFirestore.instance.collection("location")
                        .doc("ZVs9bLumD3XVY4mETi13").update({
                      "lat": animal_id_controller.text,
                      "lng": animal_name_controller.text
                    });
                    Fluttertoast.showToast(msg: "Data Updated");
                  }
                },
                child: Text(
                  "Add Details",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white)),
              elevation: 5,
              color: Colors.teal.shade800,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.3,
                onPressed: () async {
                  getUserLocation();
                  await FirebaseFirestore.instance.collection("location")
                      .doc("ZVs9bLumD3XVY4mETi13").update({
                    "lat": lat,
                    "lng": lng
                  });
                  Fluttertoast.showToast(msg: "Details added");

                },
                child: Text(
                  "Current Location",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class EnterText {
  static Widget textfield(
      BuildContext context, TextEditingController controller, String hint , int lines) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        child: TextFormField(
          maxLines: lines,
          style: TextStyle(color: Colors.teal.shade800),
          keyboardType: TextInputType.text,
          //Text field data is stored in emailController
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Enter Valid Credentials");
            }
          },
          onSaved: (value) {
            controller.text = value!;
          },
          decoration: InputDecoration(
            fillColor: Colors.teal.shade800,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: false,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade800, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}