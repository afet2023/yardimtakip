
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class AddCitizenView extends StatelessWidget {
  const AddCitizenView({super.key, required this.gelensayi});
  final int gelensayi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aile Fertlerinin TC'no larını ekle"),
      ),

      body: Center(

        child: SizedBox(
          height: 600,
          width: 400,
          child: ListView.builder(
            itemCount: gelensayi,
            itemBuilder: (context, index) {
              return Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "TC kimlik numarası:",
                  ),
                ),
              );
            },
            
            ),
        ),
      ),

    );
  }
}