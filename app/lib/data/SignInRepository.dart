import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login/LoginResponse.dart';
import '../presentation/di.dart';


class SignInRequest {
  final String email;
  final String password;

  const SignInRequest({required this.email, required this.password});
}

abstract class SignInRepositoryI {
  void signIn(
      {required SignInRequest request,
      required Function() onSuccess,
      required Function(String errMessage) onError});
}

class SignInRepository implements SignInRepositoryI {
  @override
  void signIn(
      {required SignInRequest request,
      required Function() onSuccess,
      required Function(String errMessage) onError}) {
    http.Client()
        .post(
      Uri.parse('http://10.0.2.2:3333/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': request.email,
        'password':request.password,
      }),
    )
        .then((value) {
      final jsonParsed = (jsonDecode(value.body) as Map<String, dynamic>);
      if (value.statusCode == 200) {
        LoginResponse res = LoginResponse.fromJson(jsonParsed);
        getIt.get<SharedPreferences>().setString("token", res.data.token);
        onSuccess.call();
      } else {
        var errorMessage = jsonParsed['error'];
        onError.call(errorMessage);
      }
    }).catchError((error) {
      onError.call("Unable to login,Please try again!");
    });
  }
}
