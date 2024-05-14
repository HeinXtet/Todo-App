import 'package:app/data/TodoListRepository.dart';
import 'package:app/model/todo/Todo.dart';
import 'package:app/presentation/di.dart';
import 'package:flutter/cupertino.dart';

class TodoViewModel with ChangeNotifier {
  List<Todo> todos = [];
  List<Todo> originalTodos = [];

  TodoListRepositoryI todoListRepository = getIt.get();

  void filterTodo(String keyword) {
    if(keyword.isEmpty){
      todos = originalTodos;
    }else{
      todos = todos.where((value) => value.name.toLowerCase().contains(keyword)).toList();
    }
    notifyListeners();
  }

  void getTodos(
      {required Function(List<Todo> todos) onSuccess,
      required Function(String error) onError}) {
    todoListRepository.getAllTodos(onSuccess: (todos) {
      this.todos = todos;
      this.originalTodos = todos;
      debugPrint("TODO_LIST $todos");
      notifyListeners();
    }, onError: (error) {
      onError(error);
    });
  }

  void deleteTodo(
      { required int id, required Function() onSuccess,
        required Function(String error) onError}) {
    todoListRepository.deleteTodo(id : id,onSuccess: () {
      debugPrint("Deleted Todo $id");
      onSuccess.call();
    }, onError: (error) {
      onError(error);
    });
  }

  void addTodo() {
    notifyListeners();
  }
}
