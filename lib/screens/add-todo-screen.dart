import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/input.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String title = "";
  String? details;
  @override
  void initState() {
    super.initState();

    // var appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
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
                  KosyTextButton(
                      clickFunc: () {
                        Navigator.of(context).pop();
                      },
                      child: "Go Back"),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      KosyInput(title, onChange: (val) {
                        setState(() {
                          title = val;
                        });
                      }, placeholder: "Title"),
                      SizedBox(
                        height: 20,
                      ),
                      KosyInput(
                        details ?? "",
                        onChange: (val) {
                          setState(() {
                            details = val;
                          });
                        },
                        placeholder: "Details",
                        inputType: TextInputType.multiline,
                        lines: 5,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  KosyButton(
                      clickFunc: () {
                        var appState =
                            Provider.of<AppState>(context, listen: false);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: KosyText("Done"),
                                content: KosyText(
                                    'Todo has been added to list of todos'),
                                actions: <Widget>[
                                  KosyTextButton(
                                    child: 'Ok',
                                    clickFunc: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        Todo todo = Todo(
                            id: appState.todoCount,
                            title: title,
                            details: details);

                        appState.addTodo(todo);
                      },
                      child: "Save Changes"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
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
      ),
    );
  }
}
