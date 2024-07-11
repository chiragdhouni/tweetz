part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthenticationEvent extends AuthEvent {
  final String email;
  final String password;
  final AuthType authType;

  AuthenticationEvent({
    required this.email,
    required this.password,
    required this.authType,
  });
}
