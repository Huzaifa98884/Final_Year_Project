// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/add_animals.dart';
import 'package:fyp/screens/all_reports.dart';
import 'package:fyp/screens/animal_location.dart';
import 'package:fyp/screens/animal_tracking.dart';
import 'package:fyp/screens/dashboard.dart';
import 'package:fyp/screens/detect.dart';
import 'package:fyp/screens/management_dashboard.dart';
import 'package:fyp/screens/qr_codes.dart';
import 'package:fyp/screens/qr_create.dart';
import 'package:fyp/screens/qr_result.dart';
import 'package:fyp/screens/qr_scan.dart';
import 'package:fyp/screens/reporting.dart';
import 'package:fyp/screens/scrap_data.dart';
import 'package:fyp/screens/start_tracking.dart';
import 'package:fyp/screens/management_map.dart';
import 'package:fyp/screens/registration_screen.dart';
import 'package:fyp/screens/starting_page.dart';
import 'screens/login_screen.dart';
import 'screens/animal_info.dart';
import 'screens/animals_collection.dart';
import 'package:fyp/screens/request.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
       home: //Management_Dashboard_Screen()
      //Animal_Tracking_Screen()
       //History_Playback_Screen()
      //RegistrationScreen()
       RegistrationScreen()
       //Result_QR(
      //   animal_id: "2",
      // )
       //QR_codes_collection()
      //MyCustomWidget()
      //Add_AnimalsScreen()
      //Management_Dashboard_Screen()
      //TrackingPage()
      //DetectScreen()
      //Animal_tracker()
      // Request_Screen()
    );
  }
}
