import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List payrollList = [];

  Future getPayRoll() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          leading: PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'admin',
                  child: Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 4),
                        Text('Admin'),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'createUser',
                  child: Row(
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 4),
                      Text('Create User'),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'createUser') {
                // Show the create user widget
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Create User'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Save the user data and close the dialog
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          centerTitle: true,
          title: Container(
            height: 40,
            child: Image.asset('assets/images/logo2.png', width: 80),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Add your logout function here
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.lightBlueAccent,
              Colors.blueAccent,
            ],
          ),
        ),
        child: FutureBuilder(
          future: getPayRoll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        Text('Error Fetching Data'),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          Text('No Existing Data'),
                        ],
                      ),
                    ),
                  );
                } else {
                  payrollList.isEmpty ? payrollList = snapshot.data! : null;

                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    ),
                  );
                }
              }
            }
            return const Center(
              child: SingleChildScrollView(),
            );
          },
        ),
      ),
    );
  }
}
