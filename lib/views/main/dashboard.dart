import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List payrollList = [];

  Future getPayRoll() async {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getPayRoll(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError) {
                  return Center(
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("Error Fetching Data")
                          ],
                        )
                    ),
                  );
                }
                if(snapshot.hasData) {
                  if(snapshot.data.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("No Existing Data")
                            ],
                          )
                      ),
                    );
                  }
                  else {
                    payrollList.isEmpty ? payrollList = snapshot.data! : null;

                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                          ],
                        ),
                      ),
                    );
                  }
                }
              }
              return Center(
                  child: SingleChildScrollView(

                  )
              );
            }

        )
    );
  }
}
