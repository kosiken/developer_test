import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/input.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String title = "";
  String? details;
  @override
  void initState() {
    super.initState();

    // var appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      title = widget.todo.title;
      details = widget.todo.details;
    });
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
                  Row(
                    children: [
                      KosyTextButton(
                          clickFunc: () {
                            Navigator.of(context).pop();
                          },
                          child: "Go Back"),
                      KosyTextButton(
                          clickFunc: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: "Go Home")
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
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
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: KosyText("Done"),
                                content: KosyText('Todo has been updated'),
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
                        appState.updateTodo(widget.todo.id, title, details);
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
