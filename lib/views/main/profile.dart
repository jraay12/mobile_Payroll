import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/views/main/payrolls_dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/user_dashboard.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Profile"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
              title: "Home",
              titleStyle: TextStyle(
                  fontSize: 12
              ),
              icon: Icons.home,
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              onPress: () {
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UserDashboard()));
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
