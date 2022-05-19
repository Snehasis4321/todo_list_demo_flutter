class Todo {
  final int? id;
  final String task;

  Todo({this.id, required this.task});

// used while reading the data from the database
  factory Todo.fromDB(Map<String, dynamic> data) =>
      Todo(id: data['id'], task: data['task']);

// used while putting the data on the database
  Map<String, dynamic> toDB() => {'id': id, 'task': task};
}
