import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_appdev_integrated/models/api.dart';
import 'package:mobile_appdev_integrated/views/admin/admin_dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/user_dashboard.dart';
import 'dart:convert';
import '../admin/add_user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main/user_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  final AssetImage background = const AssetImage('assets/images/background1.jpg');

  var formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

 

  showStatus({required Color color, required String text}) {    // Snackbar to show message of API Response

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(text),
            backgroundColor: color,
            padding: const EdgeInsets.all(15),
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
        )
    );
  }

  Future login(context) async {

    if(!formKey.currentState!.validate()) {
      return;
    }

    Map credentials ={
      'email': emailController.text,
      'password': passwordController.text
    };

    var response = await Api.instance.login(credentials);

    if(response.status == "fail") {
      return showStatus(color: Colors.red, text: response.message);
    }

    final pref = await SharedPreferences.getInstance();
    pref.setString("token", response.data!["token"]);

    var userResponse = await Api.instance.getUser(response.data);

    if(userResponse.status == "fail") {
      return showStatus(color: Colors.red, text: userResponse.message);
    }

    showStatus(color: Colors.green, text: response.message);

    if(userResponse.data.runtimeType == List<dynamic>) {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => AdminDashboard()));
    }else {
      pref.setString("user", response.data);
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserDashboard()));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: background,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/images/logo2.png'),
                  width: 150.0,
                  height: 150.0,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blue[900],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Sign in with your Email and Password",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 260,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: 260,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                       Container(
                        alignment: Alignment.center,
                        width: 260,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue,
                          ),
                          child: TextButton(
                           onPressed: () async {
                            bool isLoggedIn = await login(context);
                            if (isLoggedIn) {
                              Navigator.pushReplacementNamed(context, 'Dashboard');
                            }
                          },

                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


