import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List payrollList = [];

  Future<List<dynamic>> getPayRoll() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load payroll');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Add your drawer function here
          },
          icon: const Icon(Icons.menu),
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
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              alignment: Alignment.center,
              child: const Text(
                'Welcome to your Dashboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45.0),
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
                        final data = snapshot.data as List<dynamic>;
                        if (data.isEmpty) {
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
                          payrollList.isEmpty
                              ? payrollList = data
                              : null;

                          
                        }
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
