import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String title;
  final String? data;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const CustomText({
    required this.title,
    this.data,
    this.color,
    this.size,
    this.weight,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 60,
      width: 180,
      child: Row(
        children: [
          Text("$title : ",
          style: TextStyle(
            fontSize: size ?? 14,
            fontWeight: weight ?? null,
            color: color ?? Colors.black
          ),),
          Text(data!,
            style: TextStyle(
                fontSize: size ?? 14,
                fontWeight: weight ?? null,
                color: color ?? Colors.black
            ),),
        ],
      ),
    );
  }
}
