import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_appdev_integrated/views/main/user_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

void main() async {

  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  bool? loggedIn = false;
  loggedIn = pref.getBool("loggedIn");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: loggedIn == null || loggedIn == false ? LoginPage() : UserDashboard()
  ));
}


 