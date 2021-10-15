import 'package:developer_test/debug.dart';
import 'package:developer_test/models/todo.dart';
import 'package:flutter/cupertino.dart';

class AppState with ChangeNotifier {
  List<Todo> _todos = Todo.getStaticTodos();
  int _todoIdCount = 2;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  Todo getTodo(int id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  bool removeTodo(int id) {
    int len = _todos.length;
    _todos = List.from(_todos.where((element) => element.id != id));
    notifyListeners();
    return len != _todos.length;
  }

  int get todoCount {
    _todoIdCount++;
    return _todoIdCount;
  }

  void updateTodoCompleted(int id, bool completed) {
    _todos.firstWhere((element) => element.id == id).completed = completed;
    Debug.log(_todos);
    notifyListeners();
  }

  void updateTodo(int id, String title, String? details) {
    Todo todo = _todos.firstWhere((element) => element.id == id);
    todo.title = title;
    if (details != null) todo.details = details;
    notifyListeners();
  }

  List<Todo> get todos => _todos;
}
