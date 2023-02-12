import 'package:flutter/material.dart';

class WriteStyle extends StatelessWidget {
  const WriteStyle({
    Key? key,
    required this.write,
    required this.weight,
    required this.size, required this.color,
  }) : super(key: key);
  final String write;
  final FontWeight weight;
  final double size;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      write,
      style: TextStyle(fontWeight: weight, fontSize: size,color: color),
    );
  }
}
