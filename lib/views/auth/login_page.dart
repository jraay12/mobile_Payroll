import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/models/api.dart';
import 'package:mobile_appdev_integrated/models/user.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  login(context) async {

    if(!formKey.currentState!.validate()) {
      return;
    }

    Map credentials = {
      "username": emailController.text,
      "password": passwordController.text
    };

    var response = await Api.instance.login(credentials);

    if(response[1] != 200) {
      showStatus(color: Colors.red, text: response[0].message);
      return;
    }


    var getUserResponse = await Api.instance.getUser(response[0].data);

    var user = User.fromObject(getUserResponse);


    emailController.clear();
    passwordController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      )
    );
  }
}
