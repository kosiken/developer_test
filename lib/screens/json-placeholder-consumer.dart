import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';

class JsonPlaceHolderScreen extends StatelessWidget {
  const JsonPlaceHolderScreen({Key? key});

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
                    KosyText(
                      "JSONPlaceholderAPI consumer",
                      type: TextTypes.header,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KosyTextButton(
                        clickFunc:
                            Navigator.of(context, rootNavigator: true).pop,
                        child: "Back"),
                    Expanded(
                        child: ListView(children: [
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/users");
                        },
                        child: "users",
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/todos");
                        },
                        child: "todos",
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/posts");
                        },
                        child: "posts",
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/albums");
                        },
                        child: "albums",
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/photos");
                        },
                        child: "photos",
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyTextButton(
                        clickFunc: () {
                          Navigator.of(context).pushNamed("/comments");
                        },
                        child: "comments",
                        color: Colors.blue,
                      ),
                    ]))
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
