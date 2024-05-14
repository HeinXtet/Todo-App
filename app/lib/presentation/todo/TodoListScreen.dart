import 'package:app/model/todo/Todo.dart';
import 'package:app/presentation/di.dart';
import 'package:app/presentation/todo/TodoViewModel.dart';
import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  var searchInputController = TextEditingController();
  late TodoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      viewModel = context.read<TodoViewModel>();
      debugPrint("INIT_STATE ");
      getTodos();
    });
    searchInputController.addListener(() {
      viewModel.filterTodo(searchInputController.text);
    });
  }

  void getTodos() {
    viewModel.getTodos(
        onSuccess: (todos) {},
        onError: (error) {
          toastification.show(
              context: context,
              title: Text(error),
              autoCloseDuration: const Duration(seconds: 2));
        });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    var todos = viewModel.todos;
    return Scaffold(
      backgroundColor: AppColors.peachBg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 18, right: 16),
              child: SearchInput(
                controller: searchInputController,
              ),
            ),
            if (todos.isNotEmpty)
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: TodoListView(
                  todos: todos,
                  onEditTodo: (todo) async {
                    debugPrint("NAVI $todo");
                    await context.push("/todoList/new", extra: {"todo": todo});
                    getTodos();
                  },
                  deleteTodo: (id) {
                    viewModel.deleteTodo(
                        id: id,
                        onSuccess: () {
                          getTodos();
                        },
                        onError: (error) {
                          toastification.show(
                              context: context,
                              title: Text(error),
                              autoCloseDuration: const Duration(seconds: 2));
                        });
                  },
                ),
              )),
            if (todos.isEmpty) const EmptyTasksView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: () async {
          var result = await context.push("/todoList/new");
          viewModel.getTodos(onSuccess: (v) {}, onError: (e) {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                getIt.get<SharedPreferences>().remove("token");
                getIt.get<SharedPreferences>().remove("loggedIn");
                context.go("/");
              },
              icon: const Icon(Icons.logout))
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "Todo List",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.primaryBlack),
            ),
            Text(
              "Create your categories task boards.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryBlack),
            ),
          ],
        ),
        backgroundColor: AppColors.peachBg,
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;

  const SearchInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.2),
        hintStyle: TextStyle(color: AppColors.primaryBlack, fontSize: 12),
        filled: true,
        hintText: "Search Your Tasks",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("images/ic_empty.png"),
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "No tasks to plan",
              style: TextStyle(color: AppColors.primaryBlack, fontSize: 16),
            ),
            Text(
              "You can save and remind your past in here",
              style: TextStyle(color: AppColors.textMute),
            )
          ],
        ),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final Function(int id) deleteTodo;
  final Function(Todo todo) onEditTodo;

  const TodoListView(
      {super.key,
      required this.todos,
      required this.deleteTodo,
      required this.onEditTodo});

  @override
  Widget build(BuildContext context) {
    debugPrint(todos.toString());
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: SizedBox(
            height: 140,
            width: double.infinity,
            child: TodoItemView(
              deleteTodo: (id) {
                deleteTodo.call(id);
              },
              onEditTodo: (todo) {
                onEditTodo.call(todo);
              },
              todo: todos[index],
            ),
          ),
        );
      },
    );
  }
}

class TodoItemView extends StatelessWidget {
  final Todo todo;
  final Function(int id) deleteTodo;
  final Function(Todo todo) onEditTodo;

  const TodoItemView(
      {super.key,
      required this.todo,
      required this.deleteTodo,
      required this.onEditTodo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onEditTodo.call(todo);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkPink.withAlpha(30),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
        ),
        margin: const EdgeInsets.only(top: 2, bottom: 2),
        padding: const EdgeInsets.only(left: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    todo.name,
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      deleteTodo(todo.id);
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              todo.description,
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBlack.withAlpha(99),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  todo.createdAt,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryBlack.withAlpha(90)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
