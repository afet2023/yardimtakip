part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInitialEvent extends AuthenticationEvent {}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationLoginEvent({required this.email, required this.password});
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  AuthenticationRegisterEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});
}

class AuthenticationLogoutEvent extends AuthenticationEvent {}
