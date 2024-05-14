import 'package:app/model/todo/Todo.dart';
import 'package:app/presentation/new/AddNewTodoViewModel.dart';
import 'package:app/presentation/todo/TodoViewModel.dart';
import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AddNewTodoScreen extends StatefulWidget {
  final Todo? todo;

  const AddNewTodoScreen({super.key, this.todo});

  @override
  State<AddNewTodoScreen> createState() => _AddNewTodoScreenState();
}

class _AddNewTodoScreenState extends State<AddNewTodoScreen> {
  late AddNewTodoViewModel viewModel;

  final titleTextFieldController = TextEditingController();
  final detailsTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("TODO_DETAILS ${widget.todo}");
    titleTextFieldController.addListener(() {
      viewModel.updateTitle(titleTextFieldController.text);
    });
    detailsTextFieldController.addListener(() {
      viewModel.updateDetails(detailsTextFieldController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      viewModel = context.read<AddNewTodoViewModel>();
      if (widget.todo != null) {
        viewModel.updateTodoEditMode(widget.todo?.id ?? -1);
        titleTextFieldController.text = widget.todo?.name ?? "";
        detailsTextFieldController.text = widget.todo?.description ?? "";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.updateTodoEditMode(-1);
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AddNewTodoViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.peachBg,
      appBar: addAppBar(context, widget.todo != null, () {
        viewModel.saveTodo(onSuccess: () {
          context.pop("/todoList");
        }, onError: (error) {
          toastification.show(
              context: context,
              title: Text(error),
              autoCloseDuration: const Duration(seconds: 2));
        },);
      }),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titleTextFieldController,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.2),
                      hintStyle: TextStyle(
                          color: AppColors.primaryBlack, fontSize: 12),
                      filled: true,
                      hintText: "Task title",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
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
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: TextField(
                      controller: detailsTextFieldController,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.2),
                        hintStyle: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 12,
                        ),
                        filled: true,
                        hintText: "Enter task description",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
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
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget addAppBar(BuildContext context, bool isEditTodo, Function() onSaveTodo) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 18,
      ),
      onPressed: () {
        context.pop();
      },
    ),
    title: Row(
      children: [
         Expanded(
          child: Text(
            isEditTodo ? "Edit Todo" : "Add New Todo",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {
            onSaveTodo.call();
          },
          icon: const Icon(
            Icons.save,
          ),
        )
      ],
    ),
    backgroundColor: AppColors.peachBg,
  );
}
