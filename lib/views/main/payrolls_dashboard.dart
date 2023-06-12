import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_appdev_integrated/models/api.dart';

class Payrolls extends StatefulWidget {
  const Payrolls({Key? key}) : super(key: key);

  @override
  State<Payrolls> createState() => _PayrollsState();
}

class _PayrollsState extends State<Payrolls> {
  late Future<List<dynamic>> payrollData; // Future to store fetched payroll data

  @override
  void initState() {
    super.initState();
    payrollData = fetchData(); // Assign the Future from fetchData() to payrollData
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final api = Api.instance;
      final response = await http.get(Uri.parse(api.url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payrolls'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: payrollData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final payrollData = snapshot.data!;
            return ListView.builder(
              itemCount: payrollData.length,
              itemBuilder: (ctx, index) {
                final payroll = payrollData[index];
                return ListTile(
                  title: Text(payroll['employeeName']),
                  subtitle: Text('Salary: ${payroll['salary']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
