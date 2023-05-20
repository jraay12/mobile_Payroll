import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  Future getPayroll() async {

  }

  Future getPayRoll() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Dashboard"),
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
        )
    );
  }
}
