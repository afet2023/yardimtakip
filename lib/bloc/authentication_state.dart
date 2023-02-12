part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  error,
  loading,
  unauthenticated,
  unverified
}

class AuthenticationState extends Equatable {
  AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.user,
      this.volunteer,
      this.errorMessage});
  final User? user;
  final AuthenticationStatus status;
  final String? errorMessage;
  VolunteerModel? volunteer;
  @override
  // TODO: implement props
  List<Object?> get props => [user, status, errorMessage, volunteer];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    String? errorMessage,
    VolunteerModel? volunteer,
  }) {
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user,
        volunteer: volunteer ?? this.volunteer,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
