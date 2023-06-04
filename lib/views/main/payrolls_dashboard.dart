import 'package:flutter/material.dart';

class Payrolls extends StatefulWidget {
  const Payrolls({Key? key}) : super(key: key);

  @override
  State<Payrolls> createState() => _PayrollsState();
}

class _PayrollsState extends State<Payrolls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Payrolls")
    );
  }
}
