import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List payrollList = [];

  Future getPayRoll() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(width: 4),
            Text('Admin'),
          ],
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          width: 100,
          child: Image.asset('assets/images/logo2.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add your logout function here
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
