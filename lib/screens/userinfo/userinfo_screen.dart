import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:uuid/uuid.dart';

import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';

import '../../model/earthquake_victims_model.dart';
import '../../repository/firebase_auth_repository.dart';

class UserInfoView extends StatefulWidget with UserInfoConst {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => UserInfoViewState();
}

class UserInfoViewState extends State<UserInfoView> {
  int numOfPerson = 0;
  String chosenCity = '';
  var cities = <String>[
    'Adana',
    'Osmaniye',
    'Gaziantep',
    'Kilis',
    'Diyarbakır',
    'Kahramanmaraş',
    'Şanlıurfa',
    'Hatay',
    'Malatya',
    'Adıyaman'
  ];
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenCity = cities[0];
  }

  _IdentityFormState identityFormState = _IdentityFormState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depremzede Kaydı Oluştur'),
      ),
      body: Padding(
        padding: context.paddingNormal,
        child: SingleChildScrollView(
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
              SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(labelText: 'İsim Soyisim:'),
                controller: UserInfoConst.nameSurnameController,
              ),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'TC kimlik numarası:'),
                controller: UserInfoConst.citizenNumberController,
              ),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.phone,
                decoration:
                    const InputDecoration(labelText: 'Telefon Numarası'),
                controller: UserInfoConst.phoneNumberController,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text('İl ', style: context.textTheme.subtitle1!),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Expanded(
                    child: DropdownButton<String>(
                        value: chosenCity,
                        isExpanded: true,
                        items: cities
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: context.textTheme.titleMedium,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue != null) chosenCity = newValue;
                          });
                        }),
                  )
                ],
              ),
              SizedBox(height: 20),
              IdentityForm(),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'Devam Et',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  var identityList = identityFormState.save();
                  /*   var earthquakeVictims = EarthquakeVictims(
                    id: Uuid().v4(),
                    nameAndSurname: UserInfoConst.nameSurnameController.text,
                    phoneNumber: UserInfoConst.phoneNumberController.text,
                    createdAt: DateTime.now().toIso8601String(),
                    createdByVolunteerId: context
                        .read<FirebaseAuthRepository>()
                        .getCurrentUser!
                        .uid,
                    uid: UserInfoConst.citizenNumberController.text,
                    city: UserInfoConst.cityController.text,
                    familyIds: identityFormState.save(),
                  );
                  Navigator.pushNamed(context, '/inventory',
                      arguments: earthquakeVictims); */
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IdentityForm extends StatefulWidget {
  const IdentityForm({super.key});

  @override
  State<IdentityForm> createState() => _IdentityFormState();
}

class _IdentityFormState extends State<IdentityForm> {
  var identityList = <TextEditingController>[
    TextEditingController(),
  ];

  List<String> save() {
    var list = identityList.map((e) => e.text).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: identityList.length * 70,
      child: ListView.builder(
        itemCount: identityList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: TextFormField(
              controller: identityList[index],
              key: ValueKey(index),
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'TC Kimlik No (${++index}):'),
            ),
            trailing: index == identityList.length
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        identityList.add(TextEditingController());
                        //focusNode.requestFocus();
                      });
                    },
                    icon: Icon(Icons.add))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        identityList.removeAt(--index);
                      });
                    },
                    icon: Icon(Icons.remove)),
          );
        }),
      ),
    );
  }
}
