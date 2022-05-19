import 'package:flutter/material.dart';
import 'package:text_validation_advanced/database.dart';
import 'package:text_validation_advanced/model.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({Key? key}) : super(key: key);

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  int? idPressed;
  TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textcontroller,
        ),
      ),
      body: FutureBuilder<List<Todo>>(
        future: TodoDatabase.instance.getTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No Todos to show"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(snapshot.data![index].task),
                          onLongPress: () {
                            idPressed = snapshot.data![index].id;
                            print("Long pressed the button");
                            setState(() {
                              textcontroller.text = snapshot.data![index].task;
                            });
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              setState(() {
                                TodoDatabase.instance.removeTodo(
                                    snapshot.data![index].id as int);
                              });
                              print(snapshot.data![index].id);
                            },
                          ),
                        ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          idPressed != null
              ? TodoDatabase.instance
                  .updateTodo(Todo(id: idPressed, task: textcontroller.text))
              : TodoDatabase.instance.addTodo(Todo(task: textcontroller.text));
          setState(() {
            textcontroller.clear();
          });
          // print(textcontroller.text);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
