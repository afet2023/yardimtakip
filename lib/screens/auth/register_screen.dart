import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/screens/auth/register_cubit.dart';

import '../../bloc/authentication_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unverified) {
          Navigator.pop(context);
        } else if (state.status == AuthenticationStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
        else if(state.status == AuthenticationStatus.unauthenticated && state.errorMessage == "The email address is already in use by another account."){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Girmiş olduğunuz mail adresi halihazırda kullanılmaktadır."),
            ),
          );
        }
      },
      child: BlocProvider(
        create: (context) => RegisterCubit(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/svg/gsb.svg',
                          color: Colors.black87,
                          key: const Key('gsbLogo'),
                        ),
                      ),
                      Text('Hoşgeldiniz', style: context.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(
                        'Kayıt olmak için lütfen e-posta ve şifrenizi giriniz.',
                        style: context.textTheme.bodyText2,
                      ),
                      const SizedBox(height: 16),
                      _buildForm(context),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDivider(),
                      buildLogin(context)
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildNameField(),
            _buildPhoneField(),
            _buildEmailField(),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      height: 20,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Widget _buildPhoneField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white.withOpacity(0.6),
        ),
        child: BlocBuilder<RegisterCubit, RegisterCubitState>(
          builder: (context, state) {
            return TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                  print(state.phoneNumberErrorText);
                if (value.isEmpty) {
                    context.read<RegisterCubit>().changePhoneNumberErrorText('Telefon alanı boş olamaz');
                }
                else if(RegExp("^\\s*(?:\\+?(\\d{1,3}))?[-. (]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?\\s*\$").hasMatch(value)){
                    context.read<RegisterCubit>().changePhoneNumberErrorText(null);
                }
                else{
                    context.read<RegisterCubit>().changePhoneNumberErrorText("Lütfen geçerli bir telefon numarası giriniz.");
                }
              },
              decoration: InputDecoration(
                errorText: state.phoneNumberErrorText,
                labelText: "Telefon",
                border: InputBorder.none,
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white.withOpacity(0.6),
        ),
        child: BlocBuilder<RegisterCubit, RegisterCubitState>(
          builder: (context, state) {
            return TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<RegisterCubit>().changeNameSurnameErrorText('Ad Soyad alanı boş olamaz');
                }
                else{
                  context.read<RegisterCubit>().changeNameSurnameErrorText(null);
                }
              },
              decoration:  InputDecoration(
                labelText: "Ad Soyad",
                errorText: state.nameSurnameErrorText,
                border: InputBorder.none,
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white.withOpacity(0.6),
        ),
        child: BlocBuilder<RegisterCubit, RegisterCubitState>(
          builder: (context, state) {
            return TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<RegisterCubit>().changeEmailErrorText('Email alanı boş olamaz');
                } else if (!isValidEmail(value)) {
                  context.read<RegisterCubit>().changeEmailErrorText('Geçerli bir email adresi giriniz');
                }
                else{
                  context.read<RegisterCubit>().changeEmailErrorText(null);
                }
              },
              decoration: InputDecoration(
                errorText: state.mailErrorText,
                labelText: "Email",
                border: InputBorder.none,
              ),
            );
          }
        ),
      ),
    );
  }

  void callSnackbar(String error, [Color? color, VoidCallback? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      backgroundColor: color ?? Colors.red,
      duration: const Duration(milliseconds: 500),
      onVisible: onVisible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Text(error, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ));
  }

  bool isVisible = false;
  Widget _buildPasswordField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ]),
        child: BlocBuilder<RegisterCubit, RegisterCubitState>(
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<RegisterCubit>().changePasswordErrorText('Şifre alanı boş olamaz');
                } else if (value.length < 6) {
                  context.read<RegisterCubit>().changePasswordErrorText('Şifre en az 6 karakter olmalıdır');
                }
                else{
                  context.read<RegisterCubit>().changePasswordErrorText(null);
                }
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  errorText: state.passwordErrorText,
                  suffixIcon: InkWell(
                    onTap: () {
                      context.read<RegisterCubit>().changeObscureText(!state.passwordObscure);
                    },
                      child: Icon(!state.passwordObscure ? Icons.visibility: Icons.visibility_off)
                    ),
              ),
              obscureText: state.passwordObscure,
            );
          },
        ),
      ),
    );
  }

  RichText buildNoAccount(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black54),
            text: "No Account? ",
            children: [
          TextSpan(
              // hesabın olmaması burda
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
              text: 'Kayıt Ol',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black54,
              )),
        ]));
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterCubitState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              minimumSize: const Size(double.infinity, 50)),
          onPressed: !state.registerButtonEnablement ? null : () async {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              context.read<AuthenticationBloc>().add(AuthenticationRegisterEvent(
                    email: emailController.text,
                    password: passwordController.text,
                    phone: phoneController.text,
                    name: nameController.text,
                  ));
            }
          },
          child: const Text(
            "Kayıt Ol",
          ),
        );
      }
    );
  }

  Widget buildLogin(BuildContext context) {
    return GestureDetector(
        child: const Text(
          "Zaten bir hesabın var mı? Giriş Yap",
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.black54),
        ),
        onTap: () {
          Navigator.pop(context);
        });
  }
}
