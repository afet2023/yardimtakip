import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

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
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildForm(context),
            SizedBox(
              height: 20,
            ),
            _buildDivider(),
            buildLogin(context)
          ],
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
            CircleAvatar(),
            Text('Hoşgeldiniz', style: context.textTheme.titleLarge),
            SizedBox(height: 8),
            Text(
              'Kayıt olmak için lütfen e-posta ve şifrenizi giriniz.',
              style: context.textTheme.bodyText2,
            ),
            SizedBox(height: 16),
            _buildNameField(),
            _buildPhoneField(),
            _buildEmailField(),
            _buildPasswordField(),
            SizedBox(height: 20),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
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
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Telefon alanı boş olamaz';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Telefon",
            border: InputBorder.none,
          ),
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
        child: TextFormField(
          controller: nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ad Soyad alanı boş olamaz';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Ad Soyad",
            border: InputBorder.none,
          ),
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
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email alanı boş olamaz';
            } else if (!isValidEmail(value)) {
              return 'Geçerli bir email adresi giriniz';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
            border: InputBorder.none,
          ),
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
        child: StatefulBuilder(
          builder: (context, setInnerState) {
            return TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Şifre alanı boş olamaz';
                } else if (value.length < 6) {
                  return 'Şifre en az 6 karakter olmalıdır';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  suffixIcon: InkWell(
                      onTap: () {
                        setInnerState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: const Icon(Icons.visibility))),
              obscureText: !isVisible,
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

  ElevatedButton _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          minimumSize: const Size(double.infinity, 50)),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          context.read<AuthenticationBloc>().add(AuthenticationRegisterEvent(
                email: emailController.text,
                password: passwordController.text,
                phone: phoneController.text,
                name: nameController.text,
              ));
        }
      },
      child: Text(
        "Kayıt Ol",
      ),
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
