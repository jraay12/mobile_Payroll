import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:mobile_appdev_integrated/models/api.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';
import 'package:mobile_appdev_integrated/views/main/payrolls_dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> with SingleTickerProviderStateMixin{

  Future getPayroll() async {

  }

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

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState(){
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);


    super.initState();
  }


  Future getPayRoll() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: () async {

            final pref = await SharedPreferences.getInstance();

            String prefData = pref.getString('user')!;

            var userData = jsonDecode(prefData);

            print(userData['email']);

            var response = await Api.instance.logout({'email' :userData['email']});
            if(response.status == 'success') {
              print(response.message);
              pref.clear();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
            else {
              showStatus(color: Colors.red, text: "Logout Error");
            }
          },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getPayRoll(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasError) {
                return RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: Text("USER")
                );
              }
            }
            return RefreshIndicator(
              onRefresh: () async {

              },
              child: SingleChildScrollView(

              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
              title: "Profile",
              titleStyle: TextStyle(
                  fontSize: 12
              ),
              icon: Icons.person,
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              onPress: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                _animationController.reverse();
              }
          ),
          Bubble(
              title: "Payroll Logs",
              titleStyle: TextStyle(
                  fontSize: 12
              ),
              icon: Icons.paypal,
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              onPress: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Payrolls()));
                _animationController.reverse();
              }
          ),

        ],
        animation: _animation,
        iconColor: Colors.white,
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        // Flaoting Action button Icon
        iconData: Icons.money,
        backGroundColor: Colors.blueGrey,
      ),
    );
  }
}
