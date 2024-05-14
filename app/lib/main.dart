import 'dart:convert';

import 'package:app/mainviewmodel.dart';
import 'package:app/model/todo/Todo.dart';
import 'package:app/presentation/auth/AuthViewModel.dart';
import 'package:app/presentation/auth/SignInScreen.dart';
import 'package:app/presentation/auth/SignUpScreen.dart';
import 'package:app/presentation/di.dart';
import 'package:app/presentation/new/AddNewTodoScreen.dart';
import 'package:app/presentation/new/AddNewTodoViewModel.dart';
import 'package:app/presentation/onboarding/OnBoardingScreen.dart';
import 'package:app/presentation/todo/TodoListScreen.dart';
import 'package:app/presentation/todo/TodoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setupDi();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnBoardingScreen();
      },
      redirect: (context, state) async {
        var pref = await SharedPreferences.getInstance();
        if (pref.getBool("loggedIn") == true) {
          return "/todoList";
        }
        return "/";
      },
    ),
    GoRoute(
        path: "/signup",
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
        routes: [
          GoRoute(
            path: "signin",
            builder: (BuildContext context, GoRouterState state) {
              return const SignInScreen();
            },
          ),
        ]),
    GoRoute(
        path: '/todoList',
        builder: (BuildContext context, GoRouterState state) {
          return const TodoListScreen();
        },
        routes: [
          GoRoute(
            path: 'new',
            builder: (BuildContext context, GoRouterState state) {
              debugPrint("NAVIGATE ${state.extra as Map<String,dynamic>?}");
             var map =  state.extra as Map<String,dynamic>?;
             if(map != null){
               return AddNewTodoScreen(todo: map['todo'] as Todo,);
             }else{
               return const AddNewTodoScreen(todo: null,);
             }
            },
          ),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainViewModel()),
        ChangeNotifierProvider.value(value: TodoViewModel()),
        ChangeNotifierProvider.value(value: AuthViewModel()),
        ChangeNotifierProvider.value(value: AddNewTodoViewModel()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Lato"),
        routerConfig: _router,
      ),
    );
  }
}
