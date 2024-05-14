import 'dart:convert';

import 'package:app/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MainViewModel with ChangeNotifier {
  User? user;

  void getUser() {
    http.Client()
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'))
        .then((value) {
      final parsed = (jsonDecode(value.body) as Map<String, dynamic>);
      debugPrint("API_RESULT" + User.fromJson(parsed).toString());
      user = User.fromJson(parsed);
      notifyListeners();
    }).onError((error, a) {
      debugPrint("ERROR " + error.toString());
    });
  }
}
