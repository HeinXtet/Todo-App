import 'dart:convert';

import 'package:app/model/todo/Todo.dart';
import 'package:app/presentation/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class CreateTodoRequest {
  final String name;
  final String description;

  const CreateTodoRequest({required this.name, required this.description});
}

abstract class CreateTodoRepositoryI {
  void onCreateTodo(
      {required CreateTodoRequest request,
      required Function() onSuccess,
      required Function(String message) onError});

  void onEditTodo(
      { required int id, required CreateTodoRequest request,
      required Function() onSuccess,
      required Function(String message) onError});
}

class CreateTodoRepository implements CreateTodoRepositoryI {
  static const URL = "http://10.0.2.2:3333/todo";

  @override
  void onCreateTodo(
      {required CreateTodoRequest request,
      required Function() onSuccess,
      required Function(String message) onError}) {
    SharedPreferences pref = getIt.get();

    https.Client()
        .post(Uri.parse(URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': pref.getString("token").toString(),
        },
            body: jsonEncode(<String, String>{
              'name': request.name,
              'description': request.description,
            }))
        .then((value) {
      var jsonParsed = jsonDecode(value.body) as Map<String, dynamic>;
      if (value.statusCode == 200) {
        debugPrint("TodoCreated $jsonParsed");
        onSuccess.call();
      } else {
        var errorMessage = jsonParsed['error'];
        onError.call(errorMessage);
      }
    }).catchError((error) {});
  }

  @override
  void onEditTodo(
      { required int id, required CreateTodoRequest request,
      required Function() onSuccess,
      required Function(String message) onError}) {
    SharedPreferences pref = getIt.get();

    https.Client()
        .put(Uri.parse("$URL/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': pref.getString("token").toString(),
        },
        body: jsonEncode(<String, String>{
          'name': request.name,
          'description': request.description,
        }))
        .then((value) {
      var jsonParsed = jsonDecode(value.body) as Map<String, dynamic>;
      if (value.statusCode == 200) {
        debugPrint("TodoCreated $jsonParsed");
        onSuccess.call();
      } else {
        var errorMessage = jsonParsed['error'];
        onError.call(errorMessage);
      }
    }).catchError((error) {});
  }
}
