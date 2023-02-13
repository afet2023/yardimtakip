

import 'package:flutter/material.dart';

class HelpAndSupportWidgets{


  Widget helpText() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
               Padding(padding: EdgeInsets.only(left:10)),
               Text('Talep Oluştur',style: TextStyle(fontSize: 14,color: Colors.black),),
            ],
          );
  }
  Widget descriptionText() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(left:10)),
              Text('Dönüşümleri artırmak için öneri,talep ve şikayetlerinizi ',style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),),
            ],
          );
  }
  Widget descriptionTextCont() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(left:10)),
              Text('doğrudan bize iletebilirsiniz',style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),),
            ],
          );
  }

  
}