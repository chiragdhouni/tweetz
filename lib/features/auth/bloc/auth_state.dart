part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

abstract class AuthActionState extends AuthState {}

class AuthErrorState extends AuthActionState {
  final String error;

  AuthErrorState(this.error);
}

class AuthSuccessState extends AuthActionState {}
