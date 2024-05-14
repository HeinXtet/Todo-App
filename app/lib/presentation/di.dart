import 'package:app/data/CreateTodoRepository.dart';
import 'package:app/data/SignInRepository.dart';
import 'package:app/data/SignUpRepository.dart';
import 'package:app/data/TodoListRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getIt = GetIt.instance;

Future<void> setupDi() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    var pref = await SharedPreferences.getInstance();
    return pref;
  });
  getIt.registerSingleton<SignUpRepositoryI>(SignUpRepository());
  getIt.registerSingleton<SignInRepositoryI>(SignInRepository());
  getIt.registerSingleton<TodoListRepositoryI>(TodoListRepository());
  getIt.registerSingleton<CreateTodoRepositoryI>(CreateTodoRepository());
}
