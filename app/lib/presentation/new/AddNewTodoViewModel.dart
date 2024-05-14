import 'package:app/data/CreateTodoRepository.dart';
import 'package:app/presentation/di.dart';
import 'package:flutter/material.dart';

class AddNewTodoViewModel with ChangeNotifier {
  CreateTodoRepositoryI createTodoRepository = getIt.get();

  var title = "";
  var details = "";

  var todoId = -1;

  void updateTitle(value) {
    title = value;
    notifyListeners();
  }

  void updateDetails(value) {
    details = value;
    notifyListeners();
  }

  void updateTodoEditMode(int id) {
    todoId = id;
  }

  void saveTodo(
      {required Function() onSuccess,
      required Function(String error) onError}) {
    if (title != "" && details != "") {
      var request = CreateTodoRequest(name: title, description: details);
      debugPrint("TODO_ID $todoId");
      if (todoId >= 0) {
        createTodoRepository.onEditTodo(
            id: todoId,
            request: request,
            onSuccess: () {
              onSuccess();
            },
            onError: (error) {
              onError(error);
            });
      } else {
        createTodoRepository.onCreateTodo(
            request: request,
            onSuccess: () {
              onSuccess();
            },
            onError: (error) {
              onError(error);
            });
      }
    } else {
      onError("Please enter title and description");
    }
  }
}
