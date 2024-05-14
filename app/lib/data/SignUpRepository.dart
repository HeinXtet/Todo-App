import 'dart:convert';

import 'package:http/http.dart' as http;

class SignUpRequest {
  final String name;
  final String email;
  final String password;

  const SignUpRequest(
      {required this.name, required this.email, required this.password});
}

abstract class SignUpRepositoryI {
  void signup(
      {required SignUpRequest request,
      required Function() onSuccess,
      required Function(String errMessage) onError});
}

class SignUpRepository implements SignUpRepositoryI {
  static const URL = "http://10.0.2.2:3333/user/signup";

  @override
  void signup(
      {required SignUpRequest request,
      required Function() onSuccess,
      required Function(String errMessage) onError}) {
    http.Client()
        .post(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': request.name,
        'email': request.email,
        'password': request.password,
      }),
    )
        .then((value) {
      final jsonParsed = (jsonDecode(value.body) as Map<String, dynamic>);
      if (value.statusCode == 200 && jsonParsed['error'] == null) {
        onSuccess.call();
      } else {
        var errorMessage = jsonParsed['error'];
        onError.call( errorMessage);
      }
    }).catchError((error) {
      onError.call(  'Unable to register,Please try again!');
    });
  }
}
