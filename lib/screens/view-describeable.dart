import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/json-placeholder-response.dart';
// ignore: unused_import
import 'package:developer_test/models/todo.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';

class ViewDescribeableScreen<T extends Describeable> extends StatelessWidget {
  const ViewDescribeableScreen({Key? key, required this.object})
      : super(key: key);
  final T object;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SafeArea(
            child: Column(
          children: [
            KosyText(
              "JSONPlaceholderAPI " + object.screenName(),
              type: TextTypes.header,
            ),
            SizedBox(
              height: 10,
            ),
            KosyTextButton(
                clickFunc: Navigator.of(context, rootNavigator: true).pop,
                child: "Back"),
            Expanded(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: object.build(context)),
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
