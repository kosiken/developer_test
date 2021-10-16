import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/models/json-placeholder-response.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserViewScreen extends StatelessWidget {
  const UserViewScreen({Key? key, required this.user}) : super(key: key);
  final JsonPlaceholderApiUser user;

  void _launchURLBrowser(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: KosyText("Done"),
              content: KosyText('Could not launch $url'),
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        KosyTextButton(
                            clickFunc:
                                Navigator.of(context, rootNavigator: true).pop,
                            child: "Back"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: KosyText(
                        user.getAvatarString(),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KosyText(
                      user.name,
                      bold: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KosyText(
                      user.email,
                      type: TextTypes.emphasis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KosyText(
                      user.phone,
                      type: TextTypes.small,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KosyText(
                      "Web information",
                      bold: true,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView(children: [
                      Row(
                        children: [
                          KosyText(
                            "Username:",
                            bold: true,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          KosyText(
                            user.username,
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          KosyText(
                            "Website:",
                            bold: true,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          KosyTextButton(
                              child: "http://" + user.website,
                              clickFunc: () {
                                _launchURLBrowser(
                                    context, "http://" + user.website);
                              },
                              color: Colors.blue)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      KosyText(
                        "Residential information:",
                        bold: true,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyText(
                          "${user.address.suite} ${user.address.street} ${user.address.zipcode}, ${user.address.city}"),
                      Divider(),
                      KosyText(
                        "Company information:",
                        bold: true,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          KosyText(
                            "Name",
                            bold: true,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          KosyText(
                            user.company.name,
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          KosyText(
                            "bs",
                            bold: true,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          KosyText(
                            user.company.bs,
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KosyText(
                        "Catch Phrase",
                        bold: true,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      KosyText(
                        user.company.catchPhrase,
                        textAlign: TextAlign.start,
                      )
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
