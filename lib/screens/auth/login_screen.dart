import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/screens/auth/login_cubit.dart';
import '../../bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailIsValid = false;
  bool passwordIsValid = false;
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
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (state.status == AuthenticationStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Bir hata oluştu'),
            ),
          );
        }
      },
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                      Text('Tekrar Hoşgeldiniz',
                          style: context.textTheme.headline4),
                      Text(
                        'Sizin için oluşturulmuş e-posta ve şifreniz ile oturum açarak devam edebilirsiniz.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyText2,
                      ),
                      _buildForm(context),
                      const SizedBox(height: 20),
                      buildNoAccount(context)
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 16),
          _buildSignInButton(context),
        ],
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
        child: BlocBuilder<LoginCubit, LoginCubitState>(
            buildWhen: (previous, current) =>
                previous.emailErrorText != current.emailErrorText,
            builder: (context, state) {
              return TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: ((value) {
                  if (value.isEmpty) {
                    context
                        .read<LoginCubit>()
                        .changeEmailErrorText('Email boş olamaz.');
                  } else if (!isValidEmail(value)) {
                    context
                        .read<LoginCubit>()
                        .changeEmailErrorText('Email formatı hatalı');
                  } else {
                    context.read<LoginCubit>().changeEmailErrorText(null);
                  }
                }),
                decoration: InputDecoration(
                  errorText: state.emailErrorText,
                  labelText: "Email",
                  border: InputBorder.none,
                ),
              );
            }),
      ),
    );
  }

  void callSnackbar(String error, [Color? color, VoidCallback? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        child: BlocBuilder<LoginCubit, LoginCubitState>(
          buildWhen: (previous, current) =>  previous.passwordErrorText != current.passwordErrorText || previous.passwordObscureText != current.passwordObscureText,
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<LoginCubit>().changePasswordErrorText('Şifre alanı boş olamaz.');
                } else if (value.length < 6) {
                  context.read<LoginCubit>().changePasswordErrorText('Şifreniz minimum 6 haneli olmalıdır.');
                }
                else{
                  context.read<LoginCubit>().changePasswordErrorText(null);
                }
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  errorText: state.passwordErrorText,
                  border: InputBorder.none,
                  labelText: "Password",
                  suffixIcon: InkWell(
                      onTap: () {
                        context.read<LoginCubit>().changePasswordObscureText(!state.passwordObscureText);
                      },
                      child: Icon(!state.passwordObscureText ? Icons.visibility : Icons.visibility_off))),
              obscureText: state.passwordObscureText,
            );
          },
        ),
      ),
    );
  }

  GestureDetector _buildForgotPassword(BuildContext context) {
    return GestureDetector(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.black54),
        ),
        onTap: () {});
  }

  RichText buildNoAccount(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black54),
            text: "No Account? ",
            children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/sign_up');
                },
              text: 'Sign Up',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black54,
              )),
        ]));
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginCubitState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              minimumSize: const Size(double.infinity, 50)),
          onPressed: [false, null].contains(state.loginButtonEnablement) ? null : () async {
            FocusScope.of(context).unfocus();
            if (formKey.currentState!.validate()) {
              context.read<AuthenticationBloc>().add(
                    AuthenticationLoginEvent(
                        email: emailController.text,
                        password: passwordController.text),
                  );
            }
          },
          child: const Text(
            "Giriş Yap",
          ),
        );
      },
    );
  }
}
