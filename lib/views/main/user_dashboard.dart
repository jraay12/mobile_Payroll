import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:mobile_appdev_integrated/custom_widgets/custom_text.dart';
import 'package:mobile_appdev_integrated/models/api.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';
import 'package:mobile_appdev_integrated/views/main/payroll_details.dart';
import 'package:mobile_appdev_integrated/views/main/payrolls_dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> with SingleTickerProviderStateMixin {

  Map payrollData = {};
  var rate = 0;
  var userData = {};
  String tokenData = "";
  Map addressData = {};

  Future getPayroll() async {

    final pref = await SharedPreferences.getInstance();

    String token = pref.getString('token')!;

    String prefData = pref.getString("user")!;
    userData = jsonDecode(prefData);
    String userId = userData['id'].toString();

    rate = userData['rate'] ?? 0;
    tokenData = token;
    var payroll = await Api.instance.getPayroll(userId, token);
    print("wtf");
    var address = await Api.instance.getAddress(int.parse(userId), token);
    addressData = address['address'];
    pref.setString("address", addressData.toString());
    return payroll;
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

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payroll",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () async {

            final pref = await SharedPreferences.getInstance();

            String prefData = pref.getString('user')!;

            var userData = jsonDecode(prefData);

            var response = await Api.instance.logout({'email' :userData['email']});
            if(response.status == 'success') {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo[900]
                ),
                child: FutureBuilder(
                  future: getPayroll(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if(!snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("No existing data",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                    color: Colors.blue,
                                    height: 50,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        payrollData = await getPayroll();
                                        setState(() => payrollData);
                                      },
                                      child: const Text(
                                        "Refresh",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                )
                            )
                          ],
                        );
                      }
                      if(snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Error Fetching Data",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                    color: Colors.blue,
                                    height: 50,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        payrollData = await getPayroll();
                                        setState(() => payrollData);
                                      },
                                      child: const Text(
                                        "Refresh",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                )
                            )
                          ],
                        );
                      }
                      if(snapshot.hasData) {

                        payrollData.isEmpty ? payrollData = snapshot.data! : null;

                        Map payroll = payrollData['payroll'];
                        Map salary = payrollData['salary'];
                        Map deduction = payrollData['deduction'];
                        payroll['rate'] = rate;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(children: [
                              Expanded(child: CustomText(title: "Payroll",
                                data: payroll['month'],
                                color: Colors.white,
                                weight: FontWeight.bold, size: 20,)),
                              IconButton(onPressed: () async {
                                payrollData = await getPayroll();
                                setState(() => payrollData);
                              }, icon: const Icon(Icons.refresh),
                               color: Colors.white,)
                            ]),
                            Divider(thickness: 2, color: Colors.white),
                            const SizedBox(height: 20),
                            CustomText(title: "Working Days",
                              data: payroll['working_days'].toString(),
                              color: Colors.white,
                              weight: FontWeight.bold, size: 20,),
                            CustomText(title: "Total Hours Overtime",
                              data: payroll['total_hours_overtime'].toString(),
                              color: Colors.white,
                              weight: FontWeight.bold, size: 20,),
                            CustomText(title: "Rate",
                              data: "${rate.toString()} /hr",
                              color: Colors.white,
                              weight: FontWeight.bold, size: 20,),
                            SizedBox(height: 50),
                            CustomText(title: "Net Salary",
                              data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(salary['net_salary'])).toString(),
                              color: Colors.white,
                              weight: FontWeight.bold, size: 20,),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height: 40,
                                    width: size.width * 0.5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[200]
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => PayrollDetails(payroll: payroll, salary: salary, deduction: deduction)));
                                      },
                                      child: Text("VIEW DETAILS",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  },
                ),
              )
            ],
          )
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
              onPress: () async {


                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(userData: userData, address: addressData)));
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
        backGroundColor: Colors.blue,
      ),
    );
  }
}


