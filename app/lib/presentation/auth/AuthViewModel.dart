import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/SignInRepository.dart';
import 'package:app/data/SignUpRepository.dart';
import 'package:app/model/login/LoginResponse.dart';
import 'package:app/presentation/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  var name, email, password, confirmPassword = "";

  SignUpRepositoryI signUpRepository = getIt.get();
  SignInRepositoryI signInRepository = getIt.get();

  var loginStreamController = StreamController<bool>();

  var registerStreamController = PublishSubject<bool>();

  var registerEnabled = false;
  var loginEnabled = false;

  var authType = "register";

  void updateAuthType(String type) {
    authType = type;
  }

  void updateName(String value) {
    name = value;
    checkValidation();
  }

  void updateEmail(String value) {
    email = value;
    checkValidation();
  }

  void updatePassword(String value) {
    password = value;
    checkValidation();
  }

  void updateConfirmPassword(String value) {
    confirmPassword = value;
    checkValidation();
  }

  void checkValidation() {
    if (authType != "login") {
      registerEnabled = name != "" &&
          email != "" &&
          password != "" &&
          confirmPassword != "" &&
          password == confirmPassword;
      debugPrint(registerEnabled.toString());
    } else {
      loginEnabled = email != "" && password != "";
    }
    debugPrint(
      "loginEnabled $loginEnabled",
    );
    notifyListeners();
  }

  void login(
      {Function? successCallback, Function(String error)? errorCallback}) {
    signInRepository.signIn(
        request: SignInRequest(email: email, password: password),
        onSuccess: () {
          successCallback?.call();
        },
        onError: (errorMessage) {
          errorCallback?.call(errorMessage);
        });
  }

  void register(
      {Function? successCallback, Function(String err)? errorCallback}) {
    signUpRepository.signup(
        request: SignUpRequest(name: name, email: email, password: password),
        onSuccess: () {
          successCallback?.call();
        },
        onError: (errorMessage) {
          errorCallback?.call(errorMessage);
        });
  }
}
