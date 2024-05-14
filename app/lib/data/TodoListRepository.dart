import 'dart:convert';

import 'package:app/model/todo/Todo.dart';
import 'package:app/model/todo/TodoListResponse.dart';
import 'package:app/presentation/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoListRepositoryI {
  void getAllTodos(
      {required Function(List<Todo> todos) onSuccess,
      required Function(String error) onError});

  void deleteTodo(
      {required int id,
      required Function() onSuccess,
      required Function(String error) onError});
}

class TodoListRepository implements TodoListRepositoryI {
  static const URL = "http://10.0.2.2:3333/todo";

  @override
  void getAllTodos(
      {required Function(List<Todo> todos) onSuccess,
      required Function(String error) onError}) {
    SharedPreferences pref = getIt.get();

    http.Client().get(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': pref.getString("token").toString(),
      },
    ).then((value) {
      var jsonParsed = jsonDecode(value.body) as Map<String, dynamic>;
      if (value.statusCode == 200) {
        var todoListResponse = TodoListResponse.fromJson(jsonParsed);
        var items = todoListResponse.data
            .map((item) => item.copyWith(
                createdAt: DateFormat('yyyy MMM dd, HH:mm')
                    .format(DateTime.parse(item.createdAt).toLocal())))
            .toList();
        onSuccess.call(items.reversed.toList());
      } else {
        onError.call(jsonParsed['error'] ?? "");
      }
    }).catchError((error) {
      onError.call("Can't get Todo data");
    });
  }

  @override
  void deleteTodo(
      {required int id,
      required Function() onSuccess,
      required Function(String error) onError}) {

    SharedPreferences pref = getIt.get();

    http.Client().delete(
      Uri.parse("$URL/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': pref.getString("token").toString(),
      },
    ).then((value){
      var jsonParsed = jsonDecode(value.body) as Map<String, dynamic>;
      if (value.statusCode == 200) {
        onSuccess.call();
      } else {
        onError.call(jsonParsed['error'] ?? "");
      }
    }).catchError((error){
      debugPrint("Delete Todo $error");
      onError("Can't find todo to Delete");
    });
  }
}
