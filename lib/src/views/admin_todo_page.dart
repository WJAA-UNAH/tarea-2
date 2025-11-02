import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/api/todos.dart';
import 'package:todo_app/src/shared/utils.dart';

class AdminTodoPage extends StatefulWidget {
  const AdminTodoPage({super.key, this.todo});

  final Map<String, dynamic>? todo;

  @override
  State<AdminTodoPage> createState() => _AdminTodoPageState();
}

class _AdminTodoPageState extends State<AdminTodoPage> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  final FocusNode titleFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo?['title'] ?? '');
    descriptionController =
        TextEditingController(text: widget.todo?['description'] ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    titleFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Id que me permite consultar a la BBDD la información actualziada
    final todoId = GoRouterState.of(context).pathParameters['id'];


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todo == null
              ? 'Creación de una nueva tarea'
              : 'Editando la tarea # $todoId',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            TextField(
              focusNode: titleFocus,
              controller: titleController,
              decoration: InputDecoration(
                label: const Text('Titulo'),
                hintText: 'Eje. Crear opción de eliminar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                // suffixIcon: IconButton(
                //   icon: Icon(Icons.visibility),
                //   onPressed: () {},
                // ),
                prefixIcon: Icon(Icons.text_fields_rounded),
              ),

              maxLines: 1,
              maxLength: 50,
              obscureText: false,
              keyboardType: TextInputType.visiblePassword,
              // style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(label: Text('Descripción')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        onPressed: () {
          if (titleController.text.isEmpty) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       'Debe ingresar un titulo',
            //       style: TextStyle(color: Colors.red[50]),
            //     ),
            //     backgroundColor: Colors.red,
            //   ),
            // );

            Utils.showSnackBar(
              context: context,
              message: "El título es obligatorio",
              backgroundColor: Colors.red,
            );

            return;
          }

          final Map<String, dynamic> newTodo = {
            'id': todoList.length + 1,
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
          };

          if (todoId == null) {
            todoList.add(newTodo);
          } else {
            final indice = todoList.indexWhere(
              (todo) => todo['id'].toString() == todoId,
            );

            todoList[indice] = newTodo;
          }

          // final snackBar = SnackBar(
          //   content: const Text('Yay! A SnackBar!'),
          //   action: SnackBarAction(
          //     label: 'Undo',
          //     onPressed: () {
          //       // Some code to undo the change.
          //     },
          //   ),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Tarea creada correctamente'),
          //     // backgroundColor: ,
          //     duration: Duration(days: 4),
          //     action: SnackBarAction(label: 'Cerrar', onPressed: () {}),
          //   ),
          // );
          Utils.showSnackBar(
            context: context,
            message: "Tarea creada correctamente",
            backgroundColor: Colors.green,
          );

          titleController.text = '';
          descriptionController.text = '';

          context.pop();
        },
        child: Icon(Icons.add, color: Colors.blue[50]),
      ),
    );
  }
}
