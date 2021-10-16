import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/controllers/json-placeholder-api.dart';
import 'package:developer_test/debug.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';

class ModelsViewScreen<T> extends StatelessWidget {
  const ModelsViewScreen(
      {Key? key, required this.pathTogo, required this.controller})
      : super(key: key);
  final String pathTogo;
  final JsonPlaceholderController<T> controller;

  Widget buildList(BuildContext context, AsyncSnapshot<List<T>> snapshot) {
    if (snapshot.hasError)
      return KosyText(snapshot.error.toString());
    else if (snapshot.hasData) {
      List<T> data = snapshot.requireData;

      return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: KosyText(
                    "${index + 1}",
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: KosyTextButton(
                      clickFunc: () {
                        Debug.log(data[index]);
                        Navigator.of(context)
                            .pushNamed(pathTogo, arguments: data[index]);
                      },
                      child: "${data[index]}",
                      color: Colors.blue),
                ),
              ],
            ),
          );
        },
        itemCount: data.length,
      );
    } else {
      return Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 30,
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: KosyText('Awaiting results...'),
            )
          ],
        ),
      );
    }
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
                    SizedBox(
                      height: 5,
                    ),
                    KosyText(
                      "Tap or click a user to view",
                      color: TextEmphasisColor,
                      type: TextTypes.small,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: FutureBuilder<List<T>>(
                      future: controller.getAllT(),
                      builder: buildList,
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
