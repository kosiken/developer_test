import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/Todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/picker.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../debug.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onClick})
      : super(key: key);
  final Todo todo;
  final void Function(Todo t) onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          todo.completed
              ? Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                )
              : SizedBox(),
          Expanded(
            child: KosyTextButton(
                clickFunc: () {
                  onClick(todo);
                },
                child: "$todo",
                color: Colors.blue),
          ),
          KosyTextButton(
            clickFunc: () {
              var appState = Provider.of<AppState>(context, listen: false);

              appState.removeTodo(todo.id);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: KosyText("Removed"),
                      content:
                          KosyText('Todo has been removed to list of todos'),
                      actions: <Widget>[
                        KosyTextButton(
                            clickFunc: () {
                              appState.addTodo(todo);
                              Navigator.of(context).pop();
                            },
                            child: "Undo"),
                        KosyTextButton(
                          child: 'Ok',
                          clickFunc: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });

              // onClick(todo);
            },
            child: "delete",
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> categories = ["All Todos", "Completed Todos", "Pending Todos"];
  String currentCategory = "All Todos";
  // List<Todo> todos = <Todo>[];
  @override
  void initState() {
    super.initState();

    // var appState = Provider.of<AppState>(context, listen: true);
    // setState(() {
    //   todos = appState.todos;
    // });
  }

  Widget getItem(BuildContext context, int index, List<Todo> list) {
    return TodoListItem(
        todo: list[index],
        onClick: (todo) {
          Debug.log(todo);
          Navigator.of(context).pushNamed("/view-todo", arguments: todo.id);
        });
  }

  List<Todo> getTodos(List<Todo> todos) {
    if (currentCategory == "Completed Todos") {
      return List.from(todos.where((element) => element.completed));
    } else if (currentCategory == "Pending Todos") {
      return List.from(todos.where((element) => !element.completed));
    } else
      return todos;
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: true);
    var todosFiltered = getTodos(appState.todos);
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        KosyTextButton(
                            clickFunc: () {
                              Navigator.of(context)
                                  .pushNamed("/json-placeholder");
                            },
                            child: "Go to Task Two"),
                        KosyTextButton(
                            clickFunc: () {
                              Navigator.of(context).pushNamed("/add-todo");
                            },
                            child: "Add Todo")
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  KosyPicker<String>(
                    items: categories,
                    onChange: (value) {
                      setState(() {
                        currentCategory = value;
                      });
                    },
                    value: currentCategory,
                    dismissOnSelect: true,
                    height: 200,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  KosyText(
                    "Tap or click a todo to view",
                    color: TextEmphasisColor,
                    type: TextTypes.small,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  (todosFiltered.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: KosyText("No Todos found"),
                        )
                      : SizedBox()),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          getItem(context, index, todosFiltered),
                      itemCount: todosFiltered.length,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  KosyText(
                    "2021 Allison Kosy",
                    color: TextEmphasisColor,
                    type: TextTypes.small,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
