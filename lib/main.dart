import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';
import 'package:mobile_appdev_integrated/views/main/dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/dashboard.dart';

 

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: LoginPage(),
  ));
}

 