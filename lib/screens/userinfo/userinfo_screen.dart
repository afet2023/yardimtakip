import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/screens/home/home_cubit.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_widgets.dart';

class UserSaveInfo extends StatelessWidget {
  const UserSaveInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const  _UserSaveInfoPage(),
    );
  }
}

class _UserSaveInfoPage extends StatefulWidget {
  const _UserSaveInfoPage({super.key});

  @override
  State<_UserSaveInfoPage> createState() => _UserSaveInfoPageState();
}

class _UserSaveInfoPageState extends State<_UserSaveInfoPage> with UserInfoWidgets{
  bool isNameCorrect = false;
  bool isCitizenNumberCorrect = false;
  bool isPhoneNumberCorrect = false;
  bool isCityCorrect = false;
  bool isPersonCountCorrect = false;

  void _checkVariablesAndTrigger(){
    if(isNameCorrect && isCitizenNumberCorrect && isPhoneNumberCorrect && isCityCorrect && isPersonCountCorrect){
      context.read<HomeCubit>().changeContinueButtonEnablement(true);
    }
    else{
      context.read<HomeCubit>().changeContinueButtonEnablement(false);
    }
  }

  @override
  void initState() {
    UserInfoConstants.citizenNumberController.addListener(() {
        isCitizenNumberCorrect = RegExp(r"^[1-9]{1}[0-9]{10}$").hasMatch(UserInfoConstants.citizenNumberController.text);
        _checkVariablesAndTrigger();
    });
    UserInfoConstants.nameSurnameController.addListener(() {
      isNameCorrect = UserInfoConstants.nameSurnameController.text.isNotEmpty;
      _checkVariablesAndTrigger();
    });
    UserInfoConstants.phoneNumberController.addListener(() {
      isPhoneNumberCorrect =  RegExp("^\\s*(?:\\+?(\\d{1,3}))?[-. (]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?\\s*\$").hasMatch(UserInfoConstants.phoneNumberController.text);
      _checkVariablesAndTrigger();
    });
    UserInfoConstants.cityController.addListener(() {
      isCityCorrect = UserInfoConstants.cityController.text.isNotEmpty;
      _checkVariablesAndTrigger();
    });
    UserInfoConstants.numOfPersonController.addListener(() {
      isPersonCountCorrect = double.tryParse(UserInfoConstants.numOfPersonController.text) != null;
      _checkVariablesAndTrigger();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Depremzede Kaydı Oluştur',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onPrimary,
                )),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.recycling),
                onPressed: () {
                  UserInfoConstants().userControllers.forEach((element) {
                    element.text = '';
                  });
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                defaultAllPadding(),
                defaultAllPadding(),
                Text(
                  'Depremzede Kaydı İki Adımdan Oluşmaktadır',
                  style:
                      TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                ),
                Text(
                  'Birinci Adım Kişisel Bilgiler diğer Adım ise İhtiyaç Listesidir',
                  style:
                      TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                ),
                defaultVerticalPadding(),
                textFieldWidgets(),
                defaultVerticalPadding(),
                nextButton(context),
                SizedBox(height: 60)
              ],
            ),
          ),
        );
  }
}
