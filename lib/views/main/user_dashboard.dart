import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> with SingleTickerProviderStateMixin{

  Future getPayroll() async {

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
            }, icon: Icon(Icons.logout))
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
        // Floating Action button Icon
        iconData: Icons.money,
        backGroundColor: Colors.blueGrey,
      ),
    );
  }
}
