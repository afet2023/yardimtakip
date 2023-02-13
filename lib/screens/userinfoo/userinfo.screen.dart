import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yardimtakip/screens/addcitizen/addcitizen.dart';
import 'package:yardimtakip/screens/addcitizen/addcitizen_provider.dart';
import 'package:yardimtakip/screens/userinfoo/userinfo.const.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => UserInfoViewState();
}

class UserInfoViewState extends State<UserInfoView> {
  int numOfPerson = 0;
  String chosenCity = 'Adana';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depremzede Kaydı Oluştur'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Yardım kaydımız 3 adımdan oluşmaktadır',
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
            Text(
              'Her aileden en fazla 1 kişi yardım başvurusu yapabilir',
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
            nameTextField(),
            citizenTextField(),
            phoneTextField(),
            Row(
              children: [
                Text('Seçiniz'),
                Padding(padding: EdgeInsets.only(left: 10)),
                DropdownButton<String>(
                    value: chosenCity,
                    items: <String>[
                      'Adana',
                      'Osmaniye',
                      'Gaziantep',
                      'Kilis',
                      'Gaziantep',
                      'Diyarbakır',
                      'Kahramanmaraş',
                      'Şanlıurfa',
                      'Hatay',
                      'Malatya'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        chosenCity = newValue!;
                      });
                    })
              ],
            ),
            numOfMemberTextfield(),

            InkWell(

              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 350,
                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6)),
                child: Text('Devam Et',style: TextStyle(color: Colors.white),),
              ),
              onTap: () {
                numOfPerson= int.parse(userInfoConst.numOfFamilyMember.text);
                print(numOfPerson);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCitizenView(gelensayi: numOfPerson ,)));
              },
            )
          ],
        ),
      ),
    );
  }
}

class numOfMemberTextfield extends StatelessWidget {
  const numOfMemberTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: InputBorder.none, labelText: 'Aile Ferdi Sayısı'),
        controller: userInfoConst.numOfFamilyMember,
      ),
    );
  }
}

class phoneTextField extends StatelessWidget {
  const phoneTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
            border: InputBorder.none, labelText: 'Telefon Numarası'),
        controller: userInfoConst.phoneNumberController,
      ),
    );
  }
}

class citizenTextField extends StatelessWidget {
  const citizenTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: InputBorder.none, labelText: 'TC kimlik numarası:'),
        controller: userInfoConst.citizenNumberController,
      ),
    );
  }
}

class nameTextField extends StatelessWidget {
  const nameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
            border: InputBorder.none, labelText: 'İsim Soyisim:'),
        controller: userInfoConst.nameSurnameController,
      ),
    );
  }
}
