import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/views/admin_todo_page.dart';
import 'package:todo_app/src/views/home_page.dart';
import 'src/auth/login_page.dart';
import 'src/auth/register_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/todos',
            name: 'todo-list',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'create',
                name: 'new-todo',
                builder: (context, state) => const AdminTodoPage(),
              ),
              GoRoute(
                path: ':id',
                name: 'update-todo',
                builder: (context, state) {
                  final todo = state.extra as Map<String, dynamic>;
                  return AdminTodoPage(todo: todo);
                },
              ),
            ],
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Todo - App',
      // initialRoute: '/',
      // home: AdminTodoPage(), // mi primer widget personalizado
      // routes: {
      //   '/': (context) => HomePage(),
      //   '/admin-todos': (context) => AdminTodoPage(),
      // },
    );
  }
}
