import 'package:flutter/material.dart';

import 'package:developer_test/widgets/typography.dart';

// ignore: must_be_immutable
abstract class Clickable extends StatelessWidget {
  double margin = 5;
  void Function() onTheClick = () {};
  bool loading = false;

  @protected
  Clickable({required void Function() clickFunc, Key? key, loading})
      : super(key: key) {
    this.onTheClick = clickFunc;
    this.loading = loading ?? false;
//    this.child = child;
  }
  void onClick() {
    if (loading) return;
    this.onTheClick();
  }
}

/// The default button for this app
/// ignore: must_be_immutable
class KosyButton extends Clickable {
  /// The text displayed by the button
  String? child;

  /// the color of the buttons borders
  Color color = Colors.brown;
  bool disabled = false;

  /// signifies if we should add margins to the button
  late bool useMargin;

  KosyButton(
      {required void Function() clickFunc,
      required String child,
      Key? key,
      bool? disabled,
      Color? color,
      bool? loading,
      bool useMargin = false})
      : super(clickFunc: clickFunc, key: key, loading: loading) {
    this.child = child;
    this.color = color ?? this.color;
    this.disabled = disabled != null ? disabled : false;
    this.useMargin = useMargin;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.02;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: useMargin ? margin : 0, horizontal: width),
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(0x6b, 0x77, 0x9a, 0.1), // Colors.brown,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(children: [
          Expanded(
              child: Center(
            child: (this.loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : (KosyText(
                    this.child!.toUpperCase(),
                    color: this.color,
                    type: TextTypes.button,
                  ))),
          ))
        ]),
      ),
      onTap: this.onClick,
    );
  }
}

// ignore: must_be_immutable
class KosyTextButton extends Clickable {
  /// The text displayed by the button
  String? child;

  /// the color of the buttons borders
  Color color = Colors.brown;
  bool disabled = false;

  KosyTextButton(
      {required void Function() clickFunc,
      required String child,
      Key? key,
      bool? disabled,
      Color? color,
      bool? loading})
      : super(clickFunc: clickFunc, key: key, loading: loading) {
    this.child = child;
    this.color = color ?? this.color;
    this.disabled = disabled != null ? disabled : false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 23, horizontal: 15),
        child: KosyText(
          child!,
          color: disabled ? Colors.grey : this.color,
          bold: true,
        ),
      ),
      onTap: this.onClick,
    );
  }
}

/// buttons that contain a widget
/// background
/// ignore: must_be_immutable
class KosyWidgetButton extends Clickable {
  /// The text displayed by the button
  late Widget child;

  /// the color of the buttons bg
  Color color = Colors.white;
  bool disabled = false;
  bool? padding;

  KosyWidgetButton(
      {required void Function() clickFunc,
      required Widget child,
      Key? key,
      bool? disabled,
      Color? color,
      bool? loading,
      this.padding})
      : super(clickFunc: clickFunc, key: key, loading: loading) {
    this.child = child;
    this.color = color ?? this.color;
    this.disabled = disabled != null ? disabled : false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: padding == null
            ? EdgeInsets.symmetric(vertical: 10, horizontal: 15)
            : null,
        child: child,
      ),
      onTap: this.onClick,
    );
  }
}
