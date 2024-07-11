// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_workshop_tweet_app/app.dart';
import 'package:flutter_workshop_tweet_app/core/local_db/shared_pref_manager.dart';
import 'package:flutter_workshop_tweet_app/features/auth/models/user_model.dart';
import 'package:flutter_workshop_tweet_app/features/auth/repos/auth_repo.dart';
// import 'package:flutter_workshop_tweet_app/features/auth/ui/auth_register_screen.dart';
// import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthType { login, register }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticationEvent>(authenticationEvent);
  }

  FutureOr<void> authenticationEvent(
      AuthenticationEvent event, Emitter<AuthState> emit) async {
    UserCredential? credential;
    log('AuthType: ${event.authType} email: ${event.email} password: ${event.password}');
    switch (event.authType) {
      case AuthType.login:
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
            emit(AuthErrorState('No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
            emit(AuthErrorState('Wrong password provided for that user.'));
          }
        }
        break;
      case AuthType.register:
        log('AuthType: ${event.authType} email: ${event.email} password: ${event.password}');
        try {
          credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
            emit(AuthErrorState('No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
            emit(AuthErrorState('Wrong password provided for that user.'));
          }
        }
        break;
    }
    if (credential != null) {
      if (event.authType == AuthType.login) {
        UserModel? userModel = await AuthRepo.getUserRepo(credential.user!.uid);
        log(userModel!.email);

        if (userModel != null) {
          await SharedPrefManager.saveUid(credential.user!.uid);
          Decidepage.authStream.add(credential.user!.uid);
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState('User not found'));
        }
      } else if (event.authType == AuthType.register) {
        bool success = await AuthRepo.createUserRepo(UserModel(
            uid: credential.user!.uid,
            tweets: [],
            firstName: "chirag",
            lastName: "singh",
            email: credential.user!.email ?? "",
            createdAt: DateTime.now()));
        if (success) {
          await SharedPrefManager.saveUid(credential.user!.uid);
          Decidepage.authStream.add(credential.user!.uid);
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState('User not found'));
        }
      }
    } else {
      log("credential is null");
      emit(AuthErrorState('something went wrong'));
    }
  }
}
