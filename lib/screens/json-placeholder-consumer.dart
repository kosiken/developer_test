import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/Todo.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JsonPlaceHolderScreen extends StatelessWidget {
  const JsonPlaceHolderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: true);

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
                    Expanded(child: ListView(children: []))
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
