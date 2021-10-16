import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/json-placeholder-response.dart';
import 'package:developer_test/models/todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';

class ViewJPLHTodoScreen extends StatelessWidget {
  const ViewJPLHTodoScreen({Key? key, required this.todo}) : super(key: key);
  final JsonPlaceholderApiTodo todo;

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
                    //;
                    KosyText(
                      "JSONPlaceholderAPI Todo",
                      type: TextTypes.header,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KosyTextButton(
                        clickFunc:
                            Navigator.of(context, rootNavigator: true).pop,
                        child: "Back"),
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
                                    // showDialog(context: context, builder: builder)
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: KosyText("Done"),
                                            content: KosyText(
                                                'Todo cannot be updated'),
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
