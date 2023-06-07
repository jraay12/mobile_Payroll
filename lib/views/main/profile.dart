import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // New property for the user ID

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String contactNumber = '';
  String position = '';
  double rate = 0.0;
  String street = '';
  String city = '';
  String zipCode = '';
  String state = '';
  String country = '';
  String imagePath = 'assets/default_profile_picture.jpg'; // Default image path

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      name = '';
      email = '';
      contactNumber = '';
      position = '';
      rate = 25.0;
      street = '';
      city = '';
      zipCode = '';
      state = '';
      country = '';
       // imagePath remains the same as the default or can be fetched if available
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Name: $name',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'Email: $email',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      'Contact Number: $contactNumber',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text(
                      'Position: $position',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text(
                      'Rate: $rate',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      'Street: $street',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text(
                      'City: $city',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      'Zip Code: $zipCode',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      'State: $state',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      'Country: $country',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfilePage(
      userId: '', // Pass the user ID when creating the ProfilePage widget
    ),
  ));
}
