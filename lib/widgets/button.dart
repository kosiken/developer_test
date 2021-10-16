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

/// This is the class for all outlined buttons, that have a solid
/// background
/// ignore: must_be_immutable
class KosyFilledButton extends KosyButton {
  late Color textColor;
  KosyFilledButton(
      {required void Function() clickFunc,
      bool? disabled,
      Key? key,
      required String child,
      Color? color,
      bool? loading,
      bool useMargin = false,
      Color textColor = Colors.white})
      : super(
            clickFunc: clickFunc,
            key: key,
            child: child,
            color: color,
            disabled: disabled,
            loading: loading,
            useMargin: useMargin) {
    this.textColor = textColor;
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
            color: disabled ? Colors.grey : this.color,
            // border: Border.all(
            //   color: this.color, // Colors.brown,
            //   width: 4,
            //   style: BorderStyle.solid,
            // ),
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
                    color: this.textColor,
                    type: TextTypes.button,
                  ))),
          ))
        ]),
      ),
      onTap: this.onClick,
    );
  }
}

class KosyIconButton extends Clickable {
  double size = 24;
  final Color? color;
  bool border = false;
  final IconData icon;

  KosyIconButton({
    required void Function() clickFunc,
    required this.icon,
    this.color = const Color.fromRGBO(107, 119, 154, 0.5),
    Key? key,
    double? size,
    bool? border,
  }) : super(clickFunc: clickFunc, key: key) {
    this.size = size ?? this.size;
    this.border = border ?? this.border;
    // this.color = color ??
    // print(this.border);
  }
  Widget build(BuildContext context) {
    var _icon = this.icon;
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              border: (this.border == true
                  ? Border.all(
                      color: Color.fromRGBO(107, 119, 154, 0.1),
                      width: 1,
                      style: BorderStyle.solid,
                    )
                  : Border.all(width: 0, style: BorderStyle.none)),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Icon(
            _icon,
            color: this.color,
            size: this.size,
            semanticLabel: 'Text to announce in accessibility modes',
            textDirection: TextDirection.ltr,
          )),
      onTap: this.onClick,
    );
  }
}

// ignore: must_be_immutable
class KosyIconFilledButton extends KosyIconButton {
  final Color bgColor;
  KosyIconFilledButton(
      {required void Function() clickFunc,
      required IconData icon,
      this.bgColor = Colors.green,
      double? size,
      bool? border,
      Key? key,
      Color? color})
      : super(
            icon: icon,
            clickFunc: clickFunc,
            size: size,
            color: color,
            key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: bgColor,
              border: (this.border == true
                  ? Border.all(
                      color: this.bgColor,
                      width: 1,
                      style: BorderStyle.solid,
                    )
                  : Border.all(width: 0, style: BorderStyle.none)),
              borderRadius: BorderRadius.all(Radius.circular(this.size))),
          child: Center(
              child: Icon(
            icon,
            color: this.color!,
            size: this.size,
            semanticLabel: 'Text to announce in accessibility modes',
            textDirection: TextDirection.ltr,
          ))),
      onTap: this.onClick,
    );
  }
}

class KosyCheckButton extends KosyButton {
  Widget? icon;
  Color selectedColor = Color.fromRGBO(0x7F, 0X61, 0XF3, 1.0);
  bool selected;
  KosyCheckButton({
    required void Function() clickFunc,
    required String child,
    Key? key,
    bool? disabled,
    Color color = Colors.grey,
    bool? loading,
    this.icon,
    this.selected = false,
    Color? selectedColor,
  }) : super(
            clickFunc: clickFunc,
            child: child,
            key: key,
            disabled: disabled,
            color: color) {
    this.selectedColor = selectedColor ?? this.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.02;
    Color theColor = selected ? this.selectedColor : this.color;
    Widget widget = this.icon ??
        Icon(
          Icons.info,
          size: 24,
          color: theColor,
        );
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: width),
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 35),
        decoration: BoxDecoration(
            border: Border.all(
              color:
                  selected ? theColor : Color.fromRGBO(0x6b, 0x77, 0x9a, 0.1),
              width: selected ? 2 : 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            Padding(
                padding: EdgeInsets.only(left: 15),
                child: KosyText(
                  this.child!,
                  color: theColor,
                  type: TextTypes.button,
                ))
          ],
        ),
      ),
      onTap: this.onClick,
    );
  }
}

class KosyCheckExtendedButton extends KosyButton {
  Widget? icon;
  Color selectedColor = Color.fromRGBO(0x7F, 0X61, 0XF3, 1.0);
  bool selected;
  Widget theChild;
  final Color? bgColor;
  KosyCheckExtendedButton({
    required void Function() clickFunc,
    required String child,
    required Widget this.theChild,
    Key? key,
    bool? disabled,
    Color color = Colors.grey,
    bool? loading,
    this.bgColor,
    this.icon,
    this.selected = false,
    Color? selectedColor,
  }) : super(
            clickFunc: clickFunc,
            child: child,
            key: key,
            disabled: disabled,
            color: color) {
    this.selectedColor = selectedColor ?? this.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.02;
    Color theColor = selected ? this.selectedColor : this.color;

    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: width),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(
                color:
                    selected ? theColor : Color.fromRGBO(0x6b, 0x77, 0x9a, 0.1),
                width: selected ? 2 : 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: theChild),
      onTap: this.onClick,
    );
  }
}
