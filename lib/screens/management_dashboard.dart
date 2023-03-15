import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/add_animals.dart';
import 'package:fyp/screens/all_reports.dart';
import 'package:fyp/screens/animal_tracking.dart';
import 'package:fyp/screens/management_map.dart';
import 'package:fyp/screens/qr_codes.dart';
import 'package:fyp/screens/start_tracking.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Management_Dashboard_Screen extends StatelessWidget {
  Management_Dashboard_Screen({Key? key}) : super(key: key);

  bool check = false;

  get_live_location(BuildContext context) async{
    LatLng animal_location = LatLng(0.0, 0.0);
    await FirebaseFirestore.instance
        .collection('location')
        .doc("ZVs9bLumD3XVY4mETi13")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');

        animal_location =  LatLng(double.parse(documentSnapshot["lat"]), double.parse(documentSnapshot["lng"]));
        Fluttertoast.showToast(msg: animal_location.latitude.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Animal_Tracking_Screen(
                  initial_position: animal_location,
                )));
      } else {
        print('Document does not exist on the database');
        animal_location = LatLng(0.0, 0.0);
      }
    });
    return animal_location;
  }

  @override
  Widget build(BuildContext context) =>
    check == true ? Loading_Page() :Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/images/gradient.jpg"),
      //     opacity: 1,
      //     fit: BoxFit.cover,
      //   ),
      // ),
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("Wild Life" , style: TextStyle(
          fontFamily: 'Poppins'
        ),),),
        backgroundColor: Colors.teal[800],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image(
                  height: MediaQuery.of(context).size.height * 0.15,
                  image: AssetImage(
                  "assets/images/LOGO_REDLINE.png"
                ),
                color: Colors.teal[900],),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryButton.categoryButton(context, "assets/images/a.png", "Live Tracking", 0.07,  onTap: () async{
                      LatLng abc =
                      //LatLng(33.748107007846485, 73.02423155745402);
                      await get_live_location(context);

                    }),
                    CategoryButton.categoryButton(context, "assets/images/view_reports-removebg-preview.png", "View Reports", 0.05, onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Reports_Screen()));
                    })
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryButton.categoryButton(context, "assets/images/history_PB-removebg-preview.png", "History Playback",0.08, onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => History_Playback_Screen()));
                    })
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryButton.categoryButton(context, "", "Create QR" ,0.09, onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Add_AnimalsScreen()));
                    }),
                    CategoryButton.categoryButton(context, "assets/images/all_qrs-removebg-preview.png", "View QRs",0.1,onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QR_codes_collection()));
                    })
                  ],
                )
                  ]
                ),
          ),
        )
        ),
      ),

    );

}


class CategoryButton {
  static Widget categoryButton(BuildContext context, String imagePath, String text,
      double height,
      {Function? onTap}) {
    return GestureDetector(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.shade800),
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40, // Image radius
                child: imagePath==""?
                    Icon(
                      Icons.add,
                      color: Colors.teal[800],
                      size: MediaQuery.of(context).size.height * height,
                    ):
                Image.asset(
                  imagePath,
                  color: Colors.teal[800],
                  height: MediaQuery.of(context).size.height * height,
                ),
              ),
            ),
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(text, maxLines: 3,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
            ),

          ],
        ));
  }
}