import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yardimtakip/screens/user_profile/user_profile.widgets.dart';

import 'condition_widget.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({super.key});

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Kullanıcı Koşulları",
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            WriteStyle(
              write: "Kullanıcı Koşulları",
              weight: FontWeight.w600,
              size: 18,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            WriteStyle(
              write:
                  """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. 

When an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially.
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. 
Lorem Ipsum is simply dummy text of the printing and typesetting industry. 

Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry. """,
              weight: FontWeight.w400,
              size: 12,
              color: Color(0xFF616271),
            )
          ],
        ),
      )),
    );
  }
}
