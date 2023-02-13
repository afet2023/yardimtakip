import 'package:flutter/material.dart';
import 'package:yardimtakip/screens/helpandsupport/helpWidgets.dart';

class HelpAndSupportView extends StatefulWidget
    with HelpAndSupportWidgets {
  HelpAndSupportView({super.key});

  @override
  State<HelpAndSupportView> createState() => _HelpAndSupportViewState();
}

class _HelpAndSupportViewState extends State<HelpAndSupportView> with HelpAndSupportWidgets{
   String chosenSubject = 'Destek';
  TextEditingController messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.keyboard_arrow_left_rounded)],
        title: const Text(
          'Destek ve Şikayet',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                helpText(),
                descriptionText(),
                descriptionTextCont(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left:10)),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Lütfen Konu Seçiniz'),
                          Padding(padding: EdgeInsets.only(left:10)),
                          DropdownButton<String>(
                            // Step 3.
                            value: chosenSubject,
                            // Step 4.
                            items: <String>['Destek','Oneri','Sikayet']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                chosenSubject = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                      height: 250,
                      width: 350,
                      color: Colors.grey.withOpacity(0.5),
                      child: TextField(
                        controller: messageController,
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 350,
                        child: Text('Gönder',style: TextStyle(color: Colors.white,fontSize: 18)),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum MenuValues { destek, oneri, sikayet }
