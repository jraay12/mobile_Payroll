import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/custom_widgets/custom_text.dart';
import 'package:intl/intl.dart';

class PayrollDetails extends StatefulWidget {

  final payroll;
  final salary;
  final deduction;

  const PayrollDetails({
    required this.payroll,
    required this.salary,
    required this.deduction,
    Key? key}) : super(key: key);

  @override
  State<PayrollDetails> createState() => _PayrollDetailsState();
}

class _PayrollDetailsState extends State<PayrollDetails> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payslip"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[800]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Payroll Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(height: 20, thickness: 1, color: Colors.white),
                      CustomText(title: "Month", data: widget.payroll['month'], size: 16, weight: FontWeight.bold),
                      CustomText(title: "Working Days", data: widget.payroll['working_days'].toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Total Hours Overtime", data: widget.payroll['total_hours_overtime'].toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Rate", data:  (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.payroll['rate'])).toString(), size: 16, weight: FontWeight.bold),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  height: size.height * 0.40,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[800]
                  ),
                  child: Column(
                    children: [
                      Text("Deduction Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(height: 20, thickness: 1, color: Colors.white),
                      CustomText(title: "Cash Advance", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.deduction['cash_advance'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "SSS", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.deduction['sss'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Philhealth", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.deduction['philhealth'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Pagibig", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.deduction['pagibig'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Tax", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.deduction['tax'])).toString(), size: 16, weight: FontWeight.bold),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[800]
                  ),
                  child: Column(
                    children: [
                      Text("Salary Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(height: 20, thickness: 1, color: Colors.white),
                      CustomText(title: "Total Deduction", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.salary['deduction'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Gross Salary", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.salary['gross_salary'])).toString(), size: 16, weight: FontWeight.bold),
                      CustomText(title: "Net Salary", data: (NumberFormat.currency(locale: 'en_US', symbol: '').format(widget.salary['net_salary'])).toString(), size: 16, weight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
