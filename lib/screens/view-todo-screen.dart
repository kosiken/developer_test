import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewTodoScreen extends StatelessWidget {
  const ViewTodoScreen({Key? key, required this.todoId}) : super(key: key);
  final int todoId;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: true);
    var todo = appState.getTodo(todoId);

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
                    //;
                    Row(
                      children: [
                        KosyTextButton(
                            clickFunc:
                                Navigator.of(context, rootNavigator: true).pop,
                            child: "Back"),
                        KosyTextButton(
                            clickFunc: () {
                              Navigator.of(context)
                                  .pushNamed("/edit-todo", arguments: todo);
                            },
                            child: "Edit Todo"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        KosyText(
                          todo.title,
                          type: TextTypes.header,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KosyText(
                          todo.details ?? "No details",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: todo.completed,
                                  onChanged: (v) {
                                    if (v != null) {
                                      var appState = Provider.of<AppState>(
                                          context,
                                          listen: false);
                                      // showDialog(context: context, builder: builder)
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: KosyText("Done"),
                                              content: KosyText(
                                                  'Todo has been marked as ' +
                                                      (v
                                                          ? 'complete'
                                                          : 'not completed')),
                                              actions: <Widget>[
                                                KosyTextButton(
                                                  child: 'Ok',
                                                  clickFunc: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      appState.updateTodoCompleted(todoId, v);
                                    }
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              KosyText("Mark Complete")
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
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
        )));
  }
}
