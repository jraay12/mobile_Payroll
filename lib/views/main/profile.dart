import 'dart:convert';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/custom_widgets/custom_text.dart';
import 'package:mobile_appdev_integrated/models/api.dart';
import 'package:mobile_appdev_integrated/views/main/payrolls_dashboard.dart';
import 'package:mobile_appdev_integrated/views/main/user_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfilePage extends StatefulWidget {

  final userData;
  final address;

  const ProfilePage({required this.userData, required this.address, Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  late Animation<double> _animation;
  late AnimationController _animationController;
  String photoUrl = "";
  String token = "";
  var addressData;
  Future getPhoto () async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token")!;
    String prefData = pref.getString("user")!;
    var userData = jsonDecode(prefData);
    setState(() {
      photoUrl = userData['photo'];
    });
  }

  Future getAddress() async{
    final pref = await SharedPreferences.getInstance();

    String prefData = pref.getString("user")!;
    var userData = jsonDecode(prefData);
    String userId = userData['id'].toString();

    token = pref.getString("token")!;
    var address = await Api.instance.getAddress(int.parse(userId), token);
    return address;
  }

  @override
  void initState() {
    getPhoto();
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CircleAvatar(backgroundColor: Colors.blue, radius: 80),
            // SizedBox(height: 20)
            SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                          colors: [Colors.blueGrey, Colors.blueAccent],
                          radius: 0.4,
                          focal: Alignment(-0.4, -0.4),
                          tileMode: TileMode.clamp
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.25,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(size.width, 150)
                          ),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            Text(widget.userData['name'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurple
                              ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(widget.userData['position'],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),),
                            ),
                            Text(widget.userData['email'], style: TextStyle(
                              fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(
                        '${dotenv.env['API_URL']}/getPhoto/$photoUrl',
                        headers: {'Authorization': 'Bearer $token'},
                      ),
                    ),
                  ),
                ],

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  CustomText(title: "Contact No.", data: widget.userData['contact_number'], size: 18),
                  FutureBuilder(
                      future: getAddress(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          if(!snapshot.hasData || snapshot.hasError) {
                            return SizedBox();
                          }
                          if(snapshot.hasData) {
                            addressData == null ? addressData = snapshot.data! : null;
                            return Column(
                              children: [
                                CustomText(title: "Street", data: widget.address['street'], size: 18),
                                CustomText(title: "City", data: widget.address['city'], size: 18),
                                CustomText(title: "Zipcode", data: widget.address['zip_code'], size: 18),
                                CustomText(title: "Country", data: widget.address['country'], size: 20, weight: FontWeight.bold)
                              ],
                            );
                          }
                        }
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                      }
            )
                ],
              ),
            )
          ],
        ),
      ),
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
